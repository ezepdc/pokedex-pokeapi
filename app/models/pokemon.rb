class Pokemon < ApplicationRecord
  validates :name, presence: true
  validates :weight, numericality: true
  validates :idb, numericality: true
end
