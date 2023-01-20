require 'test_helper'

class PokeapiClientTest < ActiveSupport::TestCase
  test "get a Pokemon" do
    pokemon = PokeapiClient.new.get_pokemon("pikachu")
    assert_equal "pikachu", pokemon.name
    assert_equal 60, pokemon.weight
    assert_equal 25, pokemon.api_id
    assert_equal ["electric"], pokemon.types
    assert_equal ["static", "lightning-rod"], pokemon.abilities
    assert_nil pokemon.effect
    assert_nil pokemon.evolves
  end

  test "get a Pokemon with effect and evolves" do
    pokemon = PokeapiClient.new.get_pokemon("pikachu", effect: true, evolves: true)
    assert_equal "pikachu", pokemon.name
    assert_equal 60, pokemon.weight
    assert_equal 25, pokemon.api_id
    assert_equal ["electric"], pokemon.types
    assert_equal ["static", "lightning-rod"], pokemon.abilities
    assert_includes pokemon.effect, "This Pokémon is immune to damaging"
    assert_equal ["pichu", "pikachu", "raichu"], pokemon.evolves
  end

  test "get all" do
    pokemons = PokeapiClient.new.all_pokemon
    assert_equal 20, pokemons.size
    assert_equal Pokemon, pokemons.first.class
  end
end
