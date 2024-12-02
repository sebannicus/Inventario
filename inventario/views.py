from django.shortcuts import render
from django.contrib.auth import logout
from django.shortcuts import redirect

# Create your views here.

def home(request):
    return render(request, 'home.html')

def logout_view(request):
    """Cierra la sesión y redirige al login."""
    logout(request)  # Cierra la sesión del usuario
    return redirect('login')  # Redirige al login (asegúrate de que 'login' sea el nombre correcto de tu URL)
