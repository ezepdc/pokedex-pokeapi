require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
  test "validations" do
    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: 25)
    assert pokemon.valid?, "Pokémon debería ser válido"

    pokemon = Pokemon.new(weight: 6.0, idb: 25)
    assert_not pokemon.valid?, "Pokémon debería ser inválido"
    assert_equal ["no puede estar en blanco"], pokemon.errors[:name]

    pokemon = Pokemon.new(name: "Pikachu", weight: "six", idb: 25)
    assert_not pokemon.valid?, "Pokémon debería ser inválido"
    assert_equal ["no es un número"], pokemon.errors[:weight]

    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: "twenty-five")
    assert_not pokemon.valid?, "Pokémon debería ser inválido"
    assert_equal ["no es un número"], pokemon.errors[:idb]

    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: "25a")
    assert_not pokemon.valid?, "Pokémon debería ser inválido"
    assert_equal ["no es un número"], pokemon.errors[:idb]
  end
end
