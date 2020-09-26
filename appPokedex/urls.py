from django.conf.urls import  url
from .views import index,verDetalle
app_name = 'appPokedex'
urlpatterns = [
   url(r'^$', index, name='ini'),
   url(r'^detalle/(?P<pokemon_id>\d+)$',verDetalle, name = 'det' ),
  
    
]