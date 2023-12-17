class User < ApplicationRecord
  has_many :reservations

  validates :username, presence: true
end
