class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :full_name, presence: true
  has_many :categories
  has_many :expenditures

  enum role: { admin: 'admin' }

  def admin?
    role == 'admin'
  end
end
