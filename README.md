<h1>Pokédex</h1>

Se ha construido una aplicación en Ruby on Rails que despliega un Pokédex!

Esta app consume el servicio PokeApi https://pokeapi.co/ para obtener la información. En la integración se desarrolló la clase <i>PokeapiClient</i> que incluye métodos para hacer llamadas a la API y extraer la información requerida.

La aplicación se puede visualizar en el enlace https://pokedex-eze.fly.dev/pokemons donde se despliega un índice de pokemones con su respectiva:
<ul>
<li>Foto</li>
<li>Nombre</li>
<li>Tipo</li>
<li>Peso</li>
<li>Habilidades</li>
</ul>
  
En índice tiene páginación y permite realizar búsquedas de pokemones por su nombre. En caso de que no exista o haya algún error ortográfico se muestra una pantalla de error.

Al pinchar sobre un pokemon la aplicación dirige a su ficha descriptiva junto a su foto e información detallada:
<ul>
<li>Información Básica (la misma del listado)</li>
<li>Descripción</li>
<li>Evoluciones</li>
</ul>
La aplicación incluye un test del modelo Pokemon.
El mismo puede ejecutarse con el repositorio en local y desde una terminal con el comando:
<ul>
<li>rails test:models</li>
</ul>


epuyosdacosta@gmail.com
