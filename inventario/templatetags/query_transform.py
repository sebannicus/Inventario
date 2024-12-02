from django import template
from urllib.parse import urlencode

register = template.Library()

@register.simple_tag
def query_transform(request, **kwargs):
    """Modifica los parámetros de la querystring en una URL."""
    updated = request.GET.copy()
    for key, value in kwargs.items():
        updated[key] = value
    return updated.urlencode()
