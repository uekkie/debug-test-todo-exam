class Category < ApplicationRecord
  has_many :todos, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
