from django.urls import path, include
from django.shortcuts import redirect
from .auth import logout_view
from inventario.views.producto_views import (
    lista_productos,
    detalle_producto,
    crear_producto,
    editar_producto,
    eliminar_producto,
    restaurar_producto,
    registrar_movimiento,
    exportar_movimientos_csv,
    exportar_movimientos_pdf,
    filtrar_movimientos,
    exportar_csv,
)
from inventario.views.api_views import (
    ProductoListCreateView,
    ProductoDetailView,
    MovimientoListView,
    MovimientoCreateView,
)

# Definición centralizada de URLs
urlpatterns = [
    # Productos
    path('', lista_productos, name='lista_productos'),
    path('producto/<int:producto_id>/', detalle_producto, name='detalle_producto'),
    path('producto/nuevo/', crear_producto, name='crear_producto'),
    path('producto/<int:producto_id>/editar/', editar_producto, name='editar_producto'),
    path('producto/<int:producto_id>/eliminar/', eliminar_producto, name='eliminar_producto'),
    path('producto/<int:producto_id>/restaurar/', restaurar_producto, name='restaurar_producto'),

    # Movimientos
    path('movimiento/<int:producto_id>/<str:tipo>/', registrar_movimiento, name='registrar_movimiento'),
    path('movimiento/<int:producto_id>/entrada/', registrar_movimiento, {'tipo': 'ENTRADA'}, name='registrar_entrada'),
    path('movimiento/<int:producto_id>/salida/', registrar_movimiento, {'tipo': 'SALIDA'}, name='registrar_salida'),

    # Reportes
    path('reporte/csv/', exportar_csv, name='exportar_csv'),
    path('reporte/movimientos/csv/', exportar_movimientos_csv, name='exportar_movimientos_csv'),
    path('reporte/movimientos/pdf/', exportar_movimientos_pdf, name='exportar_movimientos_pdf'),
    path('movimientos/filtrar/', filtrar_movimientos, name='filtrar_movimientos'),

    # Autenticación
    path('accounts/logout/', logout_view, name='logout'),

    # API
    path('api/productos/', ProductoListCreateView.as_view(), name='api_productos'),
    path('api/productos/<int:pk>/', ProductoDetailView.as_view(), name='api_producto_detalle'),
    path('api/movimientos/', MovimientoListView.as_view(), name='api_movimientos'),
    path('api/movimientos/crear/', MovimientoCreateView.as_view(), name='api_movimientos_crear'),
]
