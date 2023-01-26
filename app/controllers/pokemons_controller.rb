class PokemonsController < ApplicationController
  before_action :set_pokemon, only: :show

  def index
    pokeapi = PokeapiClient.new
    if params[:search_term].present?
      @pokemons = [pokeapi.get_pokemon(params[:search_term].downcase)]
      @pagination = {}
    else
      query = request.query_string
      @pokemons, @pagination = pokeapi.all_pokemon(query)
    end
  rescue RestClient::NotFound
    render template: "errors/404", status: 404
  end

  def show
  end

  private

  def set_pokemon
    @pokemon = PokeapiClient.new.get_pokemon(params[:id], effect: true, evolves: true)
  end
end
