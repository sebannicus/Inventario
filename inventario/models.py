from django.db import models
from django.contrib.auth.models import User


class Producto(models.Model):
    nombre = models.CharField(max_length=100, unique=True)
    descripcion = models.TextField(blank=True)
    cantidad = models.PositiveIntegerField(default=0)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    imagen = models.ImageField(upload_to='productos/', blank=True, null=True)
    is_active = models.BooleanField(default=True)  # Eliminación lógica

    class Meta:
        permissions = [
            ("can_change_price", "Puede cambiar el precio del producto"),
        ]

    def soft_delete(self):
        """Marca el producto como inactivo."""
        self.is_active = False
        self.save()

    def restore(self):
        """Restaura un producto eliminado."""
        self.is_active = True
        self.save()

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

    def __str__(self):
        return f"{self.tipo} - {self.cantidad} {self.producto.nombre} ({self.fecha:%d/%m/%Y %H:%M})"
