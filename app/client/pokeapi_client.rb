class PokeapiClient
  def initialize
    @url = "https://pokeapi.co/api/v2"
  end

  def call(uri)
    response = RestClient.get(@url + uri)
    JSON.parse(response.body)
  end

  def get_pokemon(id, details: false, evolves: false)
    endpoint = "/pokemon/#{id}"
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

    if details == true
      get_pokemon_details(id)
    end

    if evolves == true
      get_pokemon_evolves(id)
    end
    
    pokemon
  end

  def get_pokemon_details(id)
    endpoint = "/ability/#{id}"
    response = call(endpoint)
    pokemon_details = Pokemon.new(name: response["name"], weight: response["weight"], id: response["id"])
    pokemon_details.effect_entries = response["effect_entries"].map do |effect_entry|
      effect_entry
    end

    pokemon_details
  end

  def get_pokemon_evolves(id)
    endpoint = "/evolution-chain/#{id}"
    response = call(endpoint)
    pokemon_evolves = Pokemon.new(name: response["name"], weight: response["weight"], id: response["id"])
    pokemon_evolves.chains = response["chain"]["evolves_to"].map do |chain|
      chain
    end

    pokemon_evolves
  end

  def all_pokemon(query)
    response = call("/pokemon?#{query}")
    response["results"].map do |r|
      get_pokemon(r["name"])
    end
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
