# inventario/forms.py
from django import forms
from inventario.models import Producto, MovimientoInventario
from .models import MovimientoInventario, Producto
from django.contrib.auth.models import User

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

class MovimientoForm(forms.ModelForm):
    class Meta:
        model = MovimientoInventario
        fields = ['cantidad']
        widgets = {
            'cantidad': forms.NumberInput(attrs={'class': 'form-control'}),
        }

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