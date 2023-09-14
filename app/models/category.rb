class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :icon, presence: true

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :transactions

  def total_amount
    transactions.sum(:amount)
  end
end
