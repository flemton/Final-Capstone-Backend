class TeslaModel < ApplicationRecord
  has_many :reservations, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :deposit, numericality: { greater_than_or_equal_to: 0 }
  validates :finance_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :option_to_purchase_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :total_amount_payable, numericality: { greater_than_or_equal_to: 0 }
  validates :duration, numericality: { greater_than_or_equal_to: 0 }

  def available?(start_date, end_date)
    # Logic to check if the TeslaModel is available between start_date and end_date
    reservations.where('(start_date IS NULL AND end_date IS NULL) OR
    (start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?)',
                       start_date, start_date, end_date, end_date).empty?
  end
end
