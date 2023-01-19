require 'test_helper'

class PokemonsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pokemons)
  end

  test "should get index with search term" do
    get :index, params: { search_term: "pikachu" }
    assert_response :success
    assert_not_nil assigns(:pokemon)
  end

  test "should get show" do
    pokemon = PokeapiClient.new.get_pokemon("pikachu")
    get :show, params: { id: pokemon.name }
    assert_response :success
    assert_not_nil assigns(:pokemon)
  end

  test "should handle 404 error" do
    get :index, params: { search_term: "non-existent-pokemon" }
    assert_response :not_found
    assert_template "errors/404"
  end
end
