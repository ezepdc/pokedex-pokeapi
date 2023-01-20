# Pokédex
## Descripción
Se ha construido una aplicación en Ruby on Rails que despliega un Pokédex!

Esta app consume el servicio PokeApi https://pokeapi.co/ para obtener la información. En la integración se desarrolló la clase *PokeapiClient* que incluye métodos para hacer llamadas a la API y extraer la información requerida.

La aplicación se puede visualizar en el enlace https://pokedex-eze.fly.dev/pokemons donde se despliega un índice de pokemones con su respectiva:
- Foto
- Nombre
- Tipo
- Peso
- Habilidades

En índice tiene paginación y permite realizar búsquedas de pokemones por su nombre. En caso de que no exista o haya algún error ortográfico se muestra una pantalla de error 404.

Al pinchar sobre un pokemon la aplicación dirige a su ficha descriptiva junto a su foto e información detallada:
- Información Básica (la misma del listado)
- Descripción
- Evoluciones

## Tests
La aplicación incluye test para la clase Pokemon, el controller y el client.
Para ejecutar todos los tests:
`rails test`

epuyosdacosta@gmail.com
