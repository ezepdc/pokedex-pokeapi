class Pokemon
  attr_accessor :name, :weight, :id, :photos, :types, :abilities, :effect_entries, :chains

  def initialize(name:, weight:, id:)
    @name = name
    @weight = weight
    @id = id
  end
end
