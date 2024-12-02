from django import forms
from inventario.models import Producto, MovimientoInventario
from .models import MovimientoInventario, Producto
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError


class ProductoForm(forms.ModelForm):
    class Meta:
        model = Producto
        fields = ['nombre', 'descripcion', 'cantidad', 'precio', 'imagen']
        widgets = {
            'nombre': forms.TextInput(attrs={'class': 'form-control'}),
            'descripcion': forms.Textarea(attrs={'class': 'form-control'}),
            'cantidad': forms.NumberInput(attrs={'class': 'form-control'}),
            'precio': forms.NumberInput(attrs={'class': 'form-control'}),
            'imagen': forms.ClearableFileInput(attrs={'class': 'form-control'}),
        }

    def clean_cantidad(self):
        """Valida que la cantidad no sea negativa."""
        cantidad = self.cleaned_data.get('cantidad')
        if cantidad is not None and cantidad < 0:
            raise ValidationError("La cantidad no puede ser negativa.")
        return cantidad

    def clean_precio(self):
        """Valida que el precio sea positivo."""
        precio = self.cleaned_data.get('precio')
        if precio is not None and precio <= 0:
            raise ValidationError("El precio debe ser un valor positivo.")
        return precio


class MovimientoForm(forms.ModelForm):
    class Meta:
        model = MovimientoInventario
        fields = ['cantidad']
        widgets = {
            'cantidad': forms.NumberInput(attrs={'class': 'form-control'}),
        }

    def __init__(self, *args, **kwargs):
        self.tipo = kwargs.pop('tipo', None)  # Capturar el tipo de movimiento del formulario
        self.producto = kwargs.pop('producto', None)  # Capturar el producto asociado al movimiento
        super().__init__(*args, **kwargs)

    def clean_cantidad(self):
        """Valida que la cantidad sea positiva y que haya suficiente stock en caso de salida."""
        cantidad = self.cleaned_data.get('cantidad')

        if cantidad is None or cantidad <= 0:
            raise ValidationError("La cantidad debe ser mayor a 0.")

        # Validación adicional para movimientos de tipo 'SALIDA'
        if self.tipo == 'SALIDA' and self.producto:
            if self.producto.cantidad < cantidad:
                raise ValidationError(f"Stock insuficiente: solo quedan {self.producto.cantidad} unidades de '{self.producto.nombre}'.")
        return cantidad

class FiltroMovimientoForm(forms.Form):
    producto = forms.ModelChoiceField(
        queryset=Producto.objects.all(),
        required=False,
        label="Producto"
    )
    tipo = forms.ChoiceField(
        choices=[('', 'Todos')] + MovimientoInventario.TIPO_CHOICES,
        required=False,
        label="Tipo"
    )
    fecha_inicio = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={'type': 'date'}),
        label="Fecha Inicio"
    )
    fecha_fin = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={'type': 'date'}),
        label="Fecha Fin"
    )
    responsable = forms.ModelChoiceField(
        queryset=User.objects.all(),
        required=False,
        label="Responsable"
    )

    def clean(self):
        """Valida que las fechas de inicio y fin sean coherentes."""
        cleaned_data = super().clean()
        fecha_inicio = cleaned_data.get('fecha_inicio')
        fecha_fin = cleaned_data.get('fecha_fin')

        if fecha_inicio and fecha_fin and fecha_inicio > fecha_fin:
            raise ValidationError("La fecha de inicio no puede ser posterior a la fecha de fin.")
        return cleaned_data
