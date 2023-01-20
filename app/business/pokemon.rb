class Pokemon
  attr_accessor :name, :weight, :api_id, :photos, :types, :abilities, :effect, :evolves

  def initialize(name:, weight:, api_id:)
    @name = name
    @weight = weight
    @api_id = api_id
  end
end
