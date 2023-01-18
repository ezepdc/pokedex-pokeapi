class Pokemon
  attr_accessor :name, :weight, :id, :photos, :types, :abilities, :effect, :evolves

  def initialize(name:, weight:, id:)
    @name = name
    @weight = weight
    @id = id
  end
end
