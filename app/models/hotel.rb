class Hotel < ApplicationRecord
  belongs_to :city_and_town
  validates :display_name, presence: true
end
