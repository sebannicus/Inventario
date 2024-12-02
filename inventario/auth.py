from django.contrib.auth import logout
from django.shortcuts import redirect

def logout_view(request):
    """Cerrar sesión y redirigir al login."""
    logout(request)  # Cierra la sesión del usuario
    return redirect('login')  # Redirige al login (asegúrate de que 'login' sea el nombre correcto de la URL)
