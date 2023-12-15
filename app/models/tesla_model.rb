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
end
