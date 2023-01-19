require 'test_helper'

class PokemonTest < ActiveSupport::TestCase
  test "validations" do
    #Pokemon with valid attributes
    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: 25)
    assert pokemon.valid?, "Pokemon should be valid"

    #Pokemon with a nil name
    pokemon = Pokemon.new(weight: 6.0, idb: 25)
    assert_not pokemon.valid?, "Pokemon should be invalid"
    assert_equal ["can't be blank"], pokemon.errors[:name]

    #Pokemon with a non-numeric weight
    pokemon = Pokemon.new(name: "Pikachu", weight: "six", idb: 25)
    assert_not pokemon.valid?, "Pokemon should be invalid"
    assert_equal ["is not a number"], pokemon.errors[:weight]

    #Pokemon with an id that is not numeric
    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: "twenty-five")
    assert_not pokemon.valid?, "Pokemon should be invalid"
    assert_equal ["is not a number"], pokemon.errors[:idb]

    #Pokemon with an id that is not numeric
    pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, idb: "25a")
    assert_not pokemon.valid?, "Pokemon should be invalid"
    assert_equal ["is not a number"], pokemon.errors[:idb]
  end
end
