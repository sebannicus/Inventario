from django.utils.timezone import now as django_now

def global_context(request):
    """Context processor para proporcionar la hora actual a las plantillas."""
    return {
        'now': django_now()
    }
