class PokemonsController < ApplicationController
  def index
    pokeapi = PokeapiClient.new
    if params[:search_term].present?
      @pokemon = pokeapi.get_pokemon(params[:search_term].downcase)
    else
      query = request.query_string
      @pokemons = pokeapi.all_pokemon(query)
      @next = pokeapi.next(query)
      @previous = pokeapi.previous(query)
    end
  rescue RestClient::NotFound
    render template: "errors/404", status: 404
  end

  def show
    @pokemon ||= PokeapiClient.new.get_pokemon(params[:id], effect: true, evolves: true)
  end
end
