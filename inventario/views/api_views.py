from inventario.models import Producto, MovimientoInventario
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from inventario.serializers import ProductoSerializer, MovimientoInventarioSerializer
from inventario.serializers import ProductoSerializer, MovimientoInventarioSerializer
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated


# Lista y creación de productos
class ProductoListCreateView(generics.ListCreateAPIView):
    queryset = Producto.objects.filter(is_active=True)
    serializer_class = ProductoSerializer
    authentication_classes = [BasicAuthentication]
    permission_classes = [IsAuthenticated]

# Detalles y edición de productos
class ProductoDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer
    authentication_classes = [BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def perform_destroy(self, instance):
        """
        Realiza un soft delete en lugar de eliminar físicamente el producto.
        """
        instance.soft_delete()

# Crear un movimiento de inventario
class MovimientoCreateView(generics.CreateAPIView):
    queryset = MovimientoInventario.objects.all()
    serializer_class = MovimientoInventarioSerializer
    authentication_classes = [BasicAuthentication]
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        """Registra el movimiento e incluye al usuario autenticado como responsable."""
        serializer.save(responsable=self.request.user)

# Listar movimientos de inventario
class MovimientoListView(generics.ListAPIView):
    queryset = MovimientoInventario.objects.all()
    serializer_class = MovimientoInventarioSerializer
    authentication_classes = [BasicAuthentication]
    permission_classes = [IsAuthenticated]

# Endpoint para manejar inicio de sesión
@csrf_exempt
def api_login(request):
    """
    Endpoint para manejar inicio de sesión mediante la API.
    """
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            username = data.get('username')
            password = data.get('password')

            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                return JsonResponse({'message': 'Login successful', 'user_id': user.id})
            else:
                return JsonResponse({'error': 'Invalid credentials'}, status=401)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
    return JsonResponse({'error': 'Invalid method'}, status=405)
