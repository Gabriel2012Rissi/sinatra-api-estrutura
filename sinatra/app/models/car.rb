class Car < ActiveRecord::Base
  # Validations
  validates :brand, :name, :price, presence: true
  validates :year,
    numericality: { greater_than: 1990, less_than_or_equal_to: Date.today.year },
    presence: true
end