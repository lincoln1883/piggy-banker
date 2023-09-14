class User < ApplicationRecord
  validates :full_name, presence: true
  has_many :categories
  has_many :transactions
end
