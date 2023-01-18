class PokeapiClient
  def initialize
    @url = "https://pokeapi.co/api/v2"
  end

  def call(uri)
    response = RestClient.get(@url + uri)
    JSON.parse(response.body)
  end

  def all_pokemon(query)
    response = call("/pokemon?#{query}")
    response["results"].map { |r| get_pokemon(r["name"]) }
  end

  def get_pokemon(name, effect: false, evolves: false)
    endpoint = "/pokemon/#{name}"
    response = call(endpoint)
    pokemon = Pokemon.new(name: response["name"], weight: response["weight"], id: response["id"])
    pokemon.photos = get_photos(response)
    pokemon.types = get_types(response)
    pokemon.abilities = get_abilities(response)
    pokemon.effect = get_effect(pokemon.id) if effect
    pokemon.evolves = get_evolves(pokemon.id) if evolves

    pokemon
  end

  def get_photos(response)
    response["sprites"]["other"]["home"].map { |photo| photo[1] }
  end

  def get_types(response)
    response["types"].map { |type| type["type"]["name"] }
  end

  def get_abilities(response)
    response["abilities"].map { |ability| ability["ability"]["name"] }
  end

  def get_effect(id)
    endpoint = "/ability/#{id}"
    response = call(endpoint)
    response["effect_entries"].select { |e| e["language"]["name"] == "en" }.first["effect"]
  end

  def get_evolves(id)
    endpoint = "/evolution-chain/#{id}"
    response = call(endpoint)
    get_species(response["chain"])
  end

  def get_species(response)
    evolutions = []
    evolutions << response["species"]["name"]
    current_evolution = response["evolves_to"]
    until current_evolution.empty?
      evolutions << current_evolution[0]["species"]["name"]
      current_evolution = current_evolution[0]["evolves_to"]
    end
    evolutions
  end

  def next(query)
    response = call("/pokemon?#{query}")
    URI(response["next"]).query
  end

  def previous(query)
    response = call("/pokemon?#{query}")
    URI(response["previous"]).query if response["previous"]
  end
end
