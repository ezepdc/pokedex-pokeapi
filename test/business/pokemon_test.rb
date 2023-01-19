require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
  test "create a new Pokemon" do
    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: 25)
    assert_equal "Pikachu", pokemon.name
    assert_equal 6.0, pokemon.weight
    assert_equal 25, pokemon.idb
  end
end
