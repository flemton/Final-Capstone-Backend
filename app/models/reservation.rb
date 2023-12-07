class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :tesla_model
end
