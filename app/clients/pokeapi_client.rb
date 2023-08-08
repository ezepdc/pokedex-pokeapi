class PokeapiClient
  def initialize
    @base_url = "https://pokeapi.co/api/v2"
  end

  def call(uri)
    response_body = Rails.cache.fetch(uri, expires_in: 10.seconds) do
      RestClient.get(@base_url + uri)&.body
    end

    JSON.parse(response_body)
  end

  def all_pokemon(query = "")
    response = call("/pokemon?#{query}")
    pokemons = response["results"].map { |r| get_pokemon(r["name"]) }
    pagination = {
      next: parse_query_string(response["next"]),
      prev: parse_query_string(response["previous"])
    }

    [pokemons, pagination]
  end

  def get_pokemon(name, effect: false, evolves: false)
    endpoint = "/pokemon/#{name}"
    response = call(endpoint)
    pokemon = Pokemon.new(name: response["name"], weight: response["weight"], api_id: response["id"])
    pokemon.photos = parse_photos(response)
    pokemon.types = parse_types(response)
    pokemon.abilities = parse_abilities(response)
    pokemon.effect = get_effect(pokemon.api_id) if effect
    pokemon.evolves = get_evolves(pokemon.api_id) if evolves

    pokemon
  end

  def get_effect(pokemon_id)
    endpoint = "/ability/#{pokemon_id}"
    response = call(endpoint)
    response["effect_entries"].select { |e| e["language"]["name"] == "en" }.first["effect"]
  end

  def get_evolves(pokemon_id)
    species_endpoint = "/pokemon-species/#{pokemon_id}"
    species_response = call(species_endpoint)
    evolution_chain_url = species_response["evolution_chain"]["url"]
    response = call(evolution_chain_url.gsub(@base_url, ""))
    parse_species(response["chain"])
  end

  private

  def parse_photos(response)
    response["sprites"]["other"]["home"].map { |photo| photo[1] }
  end

  def parse_types(response)
    response["types"].map { |type| type["type"]["name"] }
  end

  def parse_abilities(response)
    response["abilities"].map { |ability| ability["ability"]["name"] }
  end

  def parse_species(response)
    evolutions = []
    evolutions << response["species"]["name"]
    current_evolution = response["evolves_to"]
    until current_evolution.empty?
      evolutions << current_evolution[0]["species"]["name"]
      current_evolution = current_evolution[0]["evolves_to"]
    end

    evolutions
  end

  def parse_query_string(url)
    return if url.blank?

    URI(url).query
  end
end
