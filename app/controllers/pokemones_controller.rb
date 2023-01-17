class PokemonesController < ApplicationController
  def index
    if params[:search_term].present?
      begin
        @poke = PokeapiClient.new.get_pokemon(params[:search_term])
      rescue RestClient::NotFound
        render template: "errors/404", status: 404
      end
    else
      query = request.query_string
      @pokes = PokeapiClient.new.all_pokemon(query)
      @next = PokeapiClient.new.next(query)
      @previous = PokeapiClient.new.previous(query)
    end
  end

  def show
    @poke = PokeapiClient.new.get_pokemon(params[:id])
    @poke_details = PokeapiClient.new.get_pokemon_details(@poke.id)
    @poke_evolves = PokeapiClient.new.get_pokemon_evolves(@poke.id)
  end
end
