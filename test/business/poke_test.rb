require 'test_helper'

class PokeTest < ActiveSupport::TestCase
  test "create a new Poke object" do
    poke = Poke.new(name: "Pikachu", weight: 6.0, idb: 25)
    assert_equal "Pikachu", poke.name
    assert_equal 6.0, poke.weight
    assert_equal 25, poke.idb
  end

  test "save a new Poke object" do
    poke = Poke.new(name: "Charmander", weight: 8.5, idb: 4)
    assert poke.instance_variable_get(:@pokemon).save
  end
end
