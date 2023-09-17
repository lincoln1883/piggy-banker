class Transaction < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :category_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 1 }
  validates :user_id, presence: true

  belongs_to :category
  belongs_to :user
end
