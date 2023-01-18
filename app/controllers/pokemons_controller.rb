class PokemonsController < ApplicationController
  def index
    if params[:search_term].present?
      begin
        @pokemon = PokeapiClient.new.get_pokemon(params[:search_term].downcase)
      rescue RestClient::NotFound
        render template: "errors/404", status: 404
      end
    else
      query = request.query_string
      @pokemons = PokeapiClient.new.all_pokemon(query)
      @next = PokeapiClient.new.next(query)
      @previous = PokeapiClient.new.previous(query)
    end
  end

  def show
    @pokemon = PokeapiClient.new.get_pokemon(params[:id], effect: true, evolves: true)
  end
end
