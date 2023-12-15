class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, allow_blank: false
end
