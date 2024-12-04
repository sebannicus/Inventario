from rest_framework import serializers
from inventario.models import Producto, MovimientoInventario

class ProductoSerializer(serializers.ModelSerializer):
    """
    Serializador para el modelo Producto.
    Incluye todos los campos relevantes, incluyendo la imagen y el estado (is_active).
    """
    def validate_cantidad(self, value):
        """
        Valida que la cantidad no sea negativa.
        """
        if value < 0:
            raise serializers.ValidationError("La cantidad no puede ser negativa.")
        return value

    def validate_precio(self, value):
        """
        Valida que el precio sea mayor a cero.
        """
        if value <= 0:
            raise serializers.ValidationError("El precio debe ser mayor a cero.")
        return value

    def validate_is_active(self, value):
        """
        Valida que el campo is_active sea un valor booleano.
        """
        if not isinstance(value, bool):
            raise serializers.ValidationError("El estado (is_active) debe ser un valor booleano.")
        return value

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
    Incluye información sobre el producto, el usuario responsable, y el stock actual.
    """
    producto = serializers.StringRelatedField()  # Muestra el nombre del producto
    responsable = serializers.StringRelatedField()  # Muestra el nombre del usuario responsable
    stock_actual = serializers.SerializerMethodField()  # Campo adicional para mostrar el stock actual

    def validate(self, data):
        """
        Valida las reglas de negocio específicas para movimientos de inventario.
        """
        producto = self.instance.producto if self.instance else data.get('producto')
        tipo = data.get('tipo')
        cantidad = data.get('cantidad')

        if not producto.is_active:
            raise serializers.ValidationError("No se pueden realizar movimientos en productos inactivos.")

        if tipo == 'SALIDA':
            if producto.cantidad == 0:
                raise serializers.ValidationError("El producto no tiene stock disponible.")
            if producto.cantidad < cantidad:
                raise serializers.ValidationError("No hay suficiente stock para realizar la salida.")
        elif tipo == 'ENTRADA' and cantidad <= 0:
            raise serializers.ValidationError("La cantidad de entrada debe ser mayor a cero.")

        return data

    def get_stock_actual(self, obj):
        """
        Obtiene el stock actual del producto relacionado después del movimiento.
        """
        return obj.producto.cantidad

    class Meta:
        model = MovimientoInventario
        fields = [
            'id',           # Identificador único del movimiento
            'producto',     # Producto relacionado al movimiento
            'tipo',         # Tipo de movimiento (ENTRADA/SALIDA)
            'cantidad',     # Cantidad del movimiento
            'stock_actual', # Stock actual después del movimiento
            'fecha',        # Fecha y hora del movimiento
            'responsable'   # Usuario responsable del movimiento
        ]
