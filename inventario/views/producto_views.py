from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse
from django.http import HttpResponse, JsonResponse
from inventario.models import Producto, MovimientoInventario
from inventario.forms import MovimientoForm, FiltroMovimientoForm, ProductoForm
import csv
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from django.contrib.auth.decorators import login_required, permission_required
from django.utils.timezone import now


# Funciones Auxiliares
def filtrar_movimientos_queryset(request):
    """Filtra movimientos de inventario basado en parámetros del request."""
    form = FiltroMovimientoForm(request.GET or None)
    movimientos = MovimientoInventario.objects.all()

    if form.is_valid():
        producto = form.cleaned_data.get('producto')
        tipo = form.cleaned_data.get('tipo')
        fecha_inicio = form.cleaned_data.get('fecha_inicio')
        fecha_fin = form.cleaned_data.get('fecha_fin')

        if producto:
            movimientos = movimientos.filter(producto=producto)
        if tipo:
            movimientos = movimientos.filter(tipo=tipo)
        if fecha_inicio:
            movimientos = movimientos.filter(fecha__gte=fecha_inicio)
        if fecha_fin:
            movimientos = movimientos.filter(fecha__lte=fecha_fin)

    return movimientos, form

@login_required
def filtrar_movimientos(request):
    """Vista para filtrar movimientos de inventario."""
    movimientos, form = filtrar_movimientos_queryset(request)
    return render(request, 'inventario/filtrar_movimientos.html', {
        'form': form,
        'movimientos': movimientos
    })


# Vistas CRUD para Productos
@login_required
def lista_productos(request):
    """Lista los productos con soporte para JSON y filtros por estado."""
    estado = request.GET.get('estado', 'activos')  # Predeterminado: activos
    productos = Producto.objects.all()

    # Filtrar por estado
    if estado == 'activos':
        productos = productos.filter(is_active=True)
    elif estado == 'inactivos':
        productos = productos.filter(is_active=False)

    # Responder con JSON si se solicita
    if 'application/json' in request.headers.get('Accept', ''):
        productos_data = list(productos.values('id', 'nombre', 'descripcion', 'cantidad', 'precio', 'is_active'))
        return JsonResponse({'productos': productos_data}, safe=False)

    context = {
        'productos': productos,
        'estado': estado,
        'hora_actual': now(),
    }
    return render(request, 'inventario/lista_productos.html', context)


@login_required
def detalle_producto(request, producto_id):
    """Muestra los detalles de un producto con soporte para JSON."""
    producto = get_object_or_404(Producto, id=producto_id)

    if 'application/json' in request.headers.get('Accept', ''):
        producto_data = {
            'id': producto.id,
            'nombre': producto.nombre,
            'descripcion': producto.descripcion,
            'cantidad': producto.cantidad,
            'precio': producto.precio,
            'is_active': producto.is_active,
        }
        return JsonResponse({'producto': producto_data}, safe=False)

    return render(request, 'inventario/detalle_producto.html', {
        'producto': producto,
        'volver_url': reverse('lista_productos'),
    })


@permission_required('inventario.add_producto', raise_exception=True)
def crear_producto(request):
    """Crea un nuevo producto."""
    if request.method == 'POST':
        form = ProductoForm(request.POST, request.FILES)
        if form.is_valid():
            producto = form.save()
            if 'application/json' in request.headers.get('Accept', ''):
                return JsonResponse({'success': True, 'producto_id': producto.id}, status=201)
            return redirect(reverse('lista_productos'))
    else:
        form = ProductoForm()

    return render(request, 'inventario/crear_producto.html', {
        'form': form,
        'volver_url': reverse('lista_productos'),
    })


@permission_required('inventario.change_producto', raise_exception=True)
def editar_producto(request, producto_id):
    """Edita un producto existente."""
    producto = get_object_or_404(Producto, id=producto_id)
    if request.method == 'POST':
        form = ProductoForm(request.POST, request.FILES, instance=producto)
        if form.is_valid():
            form.save()
            if 'application/json' in request.headers.get('Accept', ''):
                return JsonResponse({'success': True}, status=200)
            return redirect(reverse('lista_productos'))
    else:
        form = ProductoForm(instance=producto)

    return render(request, 'inventario/editar_producto.html', {
        'form': form,
        'producto': producto,
        'volver_url': reverse('detalle_producto', args=[producto_id]),
    })


@permission_required('inventario.delete_producto', raise_exception=True)
def eliminar_producto(request, producto_id):
    """Elimina (lógicamente) un producto."""
    producto = get_object_or_404(Producto, id=producto_id)

    if request.method == 'POST':
        producto.soft_delete()
        if 'application/json' in request.headers.get('Accept', ''):
            return JsonResponse({'success': True}, status=200)
        return redirect(reverse('lista_productos'))

    return render(request, 'inventario/eliminar_producto.html', {
        'producto': producto,
        'volver_url': reverse('detalle_producto', args=[producto_id]),
    })


@permission_required('inventario.change_producto', raise_exception=True)
def restaurar_producto(request, producto_id):
    """Restaura un producto eliminado lógicamente."""
    producto = get_object_or_404(Producto, id=producto_id)
    if not producto.is_active:
        producto.restore()
        if 'application/json' in request.headers.get('Accept', ''):
            return JsonResponse({'success': True}, status=200)
    return redirect('lista_productos')


# Movimientos de Inventario
@login_required
def registrar_movimiento(request, producto_id, tipo):
    """Registra un movimiento de inventario."""
    producto = get_object_or_404(Producto, id=producto_id)
    if request.method == 'POST':
        form = MovimientoForm(request.POST)
        if form.is_valid():
            movimiento = form.save(commit=False)
            movimiento.producto = producto
            movimiento.tipo = tipo
            movimiento.responsable = request.user
            if tipo == 'SALIDA' and producto.cantidad < movimiento.cantidad:
                return JsonResponse({'error': 'No hay suficiente stock'}, status=400)
            producto.cantidad += movimiento.cantidad if tipo == 'ENTRADA' else -movimiento.cantidad
            producto.save()
            movimiento.save()
            return JsonResponse({'success': True}, status=201)

    elif 'application/json' in request.headers.get('Accept', ''):
        return JsonResponse({'error': 'Método no permitido'}, status=405)

    form = MovimientoForm()
    return render(request, 'inventario/registrar_movimiento.html', {'form': form, 'producto': producto, 'tipo': tipo})


# Exportar Reportes
@login_required
def exportar_movimientos_csv(request):
    """Exporta los movimientos en formato CSV."""
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="movimientos.csv"'
    writer = csv.writer(response)
    writer.writerow(['Producto', 'Tipo', 'Cantidad', 'Fecha'])

    movimientos = MovimientoInventario.objects.all()
    for movimiento in movimientos:
        writer.writerow([
            movimiento.producto.nombre,
            movimiento.tipo,
            movimiento.cantidad,
            movimiento.fecha,
        ])

    return response


@login_required
def exportar_movimientos_pdf(request):
    """Exporta los movimientos en formato PDF."""
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="movimientos.pdf"'

    p = canvas.Canvas(response, pagesize=letter)
    p.drawString(100, 750, "Reporte de Movimientos de Inventario")

    movimientos = MovimientoInventario.objects.all()
    y = 700
    for movimiento in movimientos:
        p.drawString(100, y, f"{movimiento.producto.nombre} - {movimiento.tipo} - {movimiento.cantidad} - {movimiento.fecha}")
        y -= 20

    p.save()
    return response

def exportar_csv(request):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="productos.csv"'
    writer = csv.writer(response)
    writer.writerow(['ID', 'Nombre', 'Descripción', 'Cantidad', 'Precio'])

    productos = Producto.objects.all()
    for producto in productos:
        writer.writerow([producto.id, producto.nombre, producto.descripcion, producto.cantidad, producto.precio])

    return response

