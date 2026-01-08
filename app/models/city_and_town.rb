class CityAndTown < ApplicationRecord
  self.table_name = 'cities_and_towns'
  has_many :hotels, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
