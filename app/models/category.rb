class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :icon, presence: true

  belongs_to :user
  has_many :expenditure, dependent: :destroy

  def total_amount
    expenditure.sum(:amount)
  end
end
