from django.db import models, transaction
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User

class Producto(models.Model):
    nombre = models.CharField(max_length=100, unique=True)
    descripcion = models.TextField(blank=True)
    cantidad = models.PositiveIntegerField(default=0)  # Cantidad actual en inventario
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    imagen = models.ImageField(upload_to='productos/', blank=True, null=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.nombre} - {'Activo' if self.is_active else 'Eliminado'}"

class MovimientoInventario(models.Model):
    TIPO_CHOICES = [
        ('ENTRADA', 'Entrada'),
        ('SALIDA', 'Salida'),
    ]

    producto = models.ForeignKey(
        Producto,
        on_delete=models.CASCADE,
        related_name='movimientos'
    )
    tipo = models.CharField(max_length=7, choices=TIPO_CHOICES)
    cantidad = models.PositiveIntegerField()
    fecha = models.DateTimeField(auto_now_add=True)
    responsable = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='movimientos'
    )

    def clean(self):
        """Validaciones previas al guardar."""
        if self.cantidad <= 0:
            raise ValidationError("La cantidad debe ser mayor a 0.")

        if self.tipo == 'SALIDA' and self.producto.cantidad < self.cantidad:
            raise ValidationError(
                f"Stock insuficiente: solo hay {self.producto.cantidad} unidades disponibles de {self.producto.nombre}."
            )

    def save(self, *args, **kwargs):
        """Actualiza el stock del producto al registrar un movimiento."""
        if not self.pk:  # Solo ejecuta la lógica al crear un nuevo movimiento
            if self.tipo == 'ENTRADA':
                self.producto.cantidad += self.cantidad
            elif self.tipo == 'SALIDA':
                self.producto.cantidad -= self.cantidad
            self.producto.save()
        super().save(*args, **kwargs)



    def __str__(self):
        return f"{self.tipo} - {self.cantidad} {self.producto.nombre} ({self.fecha:%d/%m/%Y %H:%M})"
