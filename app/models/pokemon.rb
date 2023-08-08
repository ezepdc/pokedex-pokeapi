class Pokemon
  include ActiveModel::Model
  attr_accessor :name, :weight, :api_id, :photos, :types, :abilities, :effect, :evolves
end
