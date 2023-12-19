class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :tesla_model

  def reservation_with_tesla_model
    {
      id:,
      start_date:,
      end_date:,
      city:,
      tesla_model: tesla_model.attributes
    }
  end
end
