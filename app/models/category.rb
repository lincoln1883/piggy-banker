class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :icon, presence: true

  belongs_to :user
  has_many :transactions
end
