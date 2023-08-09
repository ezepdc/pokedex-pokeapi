# Pokédex
## Description
A Ruby on Rails application has been built to display a Pokédex!

This app consumes the PokeApi service https://pokeapi.co/ by implementing Rails caching, which helps improve the performance of the site and reduces the number of requests made to the API. In the integration, the PokeapiClient class was developed, which includes methods to make API calls and extract the required information, utilizing cached data whenever possible.

The application can be viewed at the link https://pokedex-eze.fly.dev where it displays an index of Pokémon with their respective:

- Photo
- Name
- Type
- Weight
- Abilities

The index has pagination and allows searching for Pokémon by their name. In case it doesn't exist or there is a spelling error, a 404 error screen is displayed.

Clicking on a Pokémon directs the application to its descriptive record along with its photo and detailed information:

- Basic Information (mirroring the index)
- Description
- Evolutions

## Tests
The application includes tests for the Pokemon class, the controller, and the client. To run all the tests:
`rails test`

epuyosdacosta@gmail.com
