# inventario/admin.py
from django.contrib import admin
from .models import Producto

class ProductoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'descripcion', 'cantidad', 'precio', 'imagen_preview')
    search_fields = ('nombre',)
    list_editable = ('cantidad', 'precio')

    # Método para mostrar la imagen en miniatura en el admin
    def imagen_preview(self, obj):
        if obj.imagen:
            return format_html(f'<img src="{obj.imagen.url}" style="max-width: 50px; max-height: 50px;" />')
        return "No Image"

    imagen_preview.short_description = "Vista Previa"

admin.site.register(Producto, ProductoAdmin)
