class Transaction < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :category_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 1}

  belongs_to :category
  belongs_to :author, class_name: 'User', primary_key: :user_id
end
