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
    response["results"].map do |r|
      get_pokemon(r["name"])
    end
  end

  def get_pokemon(name, effect: false, evolves: false)
    endpoint = "/pokemon/#{name}"
    response = call(endpoint)
    pokemon = Pokemon.new(name: response["name"], weight: response["weight"], id: response["id"])
    pokemon.photos = response["sprites"]["other"]["home"].map do |photo|
      photo[1]
    end
    pokemon.types = response["types"].map do |type|
      type["type"]["name"]
    end
    pokemon.abilities = response["abilities"].map do |ability|
      ability["ability"]["name"]
    end

    if effect == true
      pokemon.effect = get_pokemon_effect(pokemon.id)
    end

    if evolves == true
      pokemon.evolves = get_pokemon_evolves(pokemon.id)
    end

    pokemon
  end

  def get_pokemon_effect(id)
    endpoint = "/ability/#{id}"
    response = call(endpoint)
    response["effect_entries"].select { |e| e["language"]["name"] == "en" }.first["effect"]
  end

  def get_pokemon_evolves(id)
    endpoint = "/evolution-chain/#{id}"
    response = call(endpoint)
    get_species(response["chain"])
  end

  def get_species(response)
    evolutions = []
    evolutions << response["species"]["name"]
    current_evolution = response["evolves_to"]
    while !current_evolution.empty? do
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
