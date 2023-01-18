require "test_helper"

class PokemonTest < ActiveSupport::TestCase
  def setup
    @pokemon = Pokemon.new(name: "Pikachu", weight: 6.0, id: 25)
  end

  def test_name
    assert_equal "Pikachu", @pokemon.name
  end

  def test_weight
    assert_equal 6.0, @pokemon.weight
  end

  def test_id
    assert_equal 25, @pokemon.id
  end

  def test_photos
    assert_nil @pokemon.photos
  end

  def test_types
    assert_nil @pokemon.types
  end

  def test_abilities
    assert_nil @pokemon.abilities
  end

  def test_effect
    assert_nil @pokemon.effect
  end

  def test_evolves
    assert_nil @pokemon.evolves
  end
end
