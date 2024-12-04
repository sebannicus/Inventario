from inventario.models import Producto, MovimientoInventario
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework import generics
from inventario.serializers import ProductoSerializer, MovimientoInventarioSerializer
from rest_framework.permissions import IsAuthenticated

# Lista y creación de productos
class ProductoListCreateView(generics.ListCreateAPIView):
    queryset = Producto.objects.filter(is_active=True)
    serializer_class = ProductoSerializer
    permission_classes = [IsAuthenticated]

# Detalles y edición de productos
class ProductoDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer
    permission_classes = [IsAuthenticated]

    def perform_destroy(self, instance):
        """
        Realiza un soft delete en lugar de eliminar físicamente el producto.
        """
        instance.soft_delete()

# Lista de movimientos
class MovimientoListView(generics.ListAPIView):
    queryset = MovimientoInventario.objects.all()
    serializer_class = MovimientoInventarioSerializer
    permission_classes = [IsAuthenticated]

# Registrar un movimiento
class MovimientoCreateView(generics.CreateAPIView):
    queryset = MovimientoInventario.objects.all()
    serializer_class = MovimientoInventarioSerializer
    permission_classes = [IsAuthenticated]
