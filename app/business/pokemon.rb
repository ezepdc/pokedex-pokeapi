class Pokemon
  attr_accessor :name, :weight, :idb, :photos, :types, :abilities, :effect, :evolves

  def initialize(name:, weight:, idb:)
    @name = name
    @weight = weight
    @idb = idb
  end
end
