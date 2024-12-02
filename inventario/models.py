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
    )  # Usuario responsable del movimiento
    stock_despues = models.PositiveIntegerField(default=0)  # Stock después del movimiento

    def save(self, *args, **kwargs):
        """Sobrescribe el método save para actualizar el stock del producto y guardar el stock después del movimiento."""
        if self.tipo == 'ENTRADA':
            self.producto.cantidad += self.cantidad
        elif self.tipo == 'SALIDA':
            self.producto.cantidad -= self.cantidad

        self.producto.save()

        # Almacena el stock actual después del movimiento
        self.stock_despues = self.producto.cantidad
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.tipo} - {self.cantidad} {self.producto.nombre} ({self.fecha:%d/%m/%Y %H:%M})"
