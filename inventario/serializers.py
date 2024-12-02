from rest_framework import serializers
from inventario.models import Producto, MovimientoInventario

class ProductoSerializer(serializers.ModelSerializer):
    """
    Serializador para el modelo Producto.
    Incluye todos los campos relevantes, incluyendo la imagen y el estado (is_active).
    """
    class Meta:
        model = Producto
        fields = [
            'id',          # Identificador único del producto
            'nombre',      # Nombre del producto
            'descripcion', # Descripción del producto
            'cantidad',    # Cantidad en inventario
            'precio',      # Precio del producto
            'is_active',   # Estado del producto (activo/inactivo)
            'imagen'       # URL o path de la imagen
        ]


class MovimientoInventarioSerializer(serializers.ModelSerializer):
    """
    Serializador para el modelo MovimientoInventario.
    Incluye información sobre el producto y el usuario responsable.
    """
    producto = serializers.StringRelatedField()  # Muestra el nombre del producto
    responsable = serializers.StringRelatedField()  # Muestra el nombre del usuario responsable

    class Meta:
        model = MovimientoInventario
        fields = [
            'id',          # Identificador único del movimiento
            'producto',    # Producto relacionado al movimiento
            'tipo',        # Tipo de movimiento (ENTRADA/SALIDA)
            'cantidad',    # Cantidad del movimiento
            'fecha',       # Fecha y hora del movimiento
            'responsable'  # Usuario responsable del movimiento
        ]
