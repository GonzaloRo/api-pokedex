from django.shortcuts import render
from django.http import HttpResponse
import requests

# Create your views here.
def index(request):
    respons = requests.get(' https://pokeapi.co/api/v2/pokemon?limit=150&offset=0')#url para traer la informacion inicial de los primero 150 pokemons
    if respons.status_code == 200: #comprueba que la conexion a la api no haya fallado      
        diccionario = respons.json() # vuelve los datos obtenidos en un json             
        contexto = {'pokemons': diccionario['results']}   # se obtiene un dicionario de datos de solo donde existe el nombre y el numero    
        return render (request, 'index.html', contexto)
    else: #si la conexion falla se renvia a la pagina sin ningun contexto
         return render (request, 'index.html')

def verDetalle(request,pokemon_id):# se recibe el id del pokemon que se desea saber el detalle
    response = requests.get(' https://pokeapi.co/api/v2/pokemon-species/'+pokemon_id+'/') # se obtiene el detalle del pokemon seleccionado en la cuadricula
    if response.status_code == 200:   #comprueba que la conexion a la api no haya fallado    
        
        descripcion = response.json()# vuelve los datos obtenidos en un json  
        for favor in descripcion['flavor_text_entries']: # se realiaza un ciclo for para obtener todas las descripciones del pokemon
            if favor['language']['name'] == 'es': # se busca que el lenguaje de la descripcion sea español si se desea en otro idioma solo se debe cambiar el "es" por la sigla del idioma deseado
               text = favor['flavor_text'] # se guarda la descripcion en el idioma deseado
        for gener in descripcion['genera']: # se realiaza un ciclo for para obtener todas las descripciones de genero del pokemon
            if gener['language']['name'] == 'es':# se busca que el lenguaje de la descripcion del genero que este en español si se desea en otro idioma solo se debe cambiar el "es" por la sigla del idioma deseado
                genera = gener['genus'] # se guarda el genera en el idioma deseado
        detallePok = {'nombre': descripcion['name'], 'id' : descripcion['id'] ,'descripPoke': text , 'gene': genera}  # se crea un diccionario con los datos obtenidos
        contexto = {'descrip' : detallePok}    #creacion del contexto para utilizar en el html
        return render (request, 'detalleP.html', contexto)
    else:    
        
        return render (request, 'detalleP.html')
