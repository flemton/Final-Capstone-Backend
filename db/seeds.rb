# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
TeslaModel.create(
        name: "Model 3",
        description: "Enjoy a whisper-quiet cabin, thanks to 360-degree acoustic glass. Take in the sky underneath an all-glass roof that lets in light while protecting you from harmful UV rays.",
        deposit: 3432,
        finance_fee: 524,
        option_to_purchase_fee: 3253,
        total_amount_payable: 535325,
        duration: 3,
        removed: false,
    ).tap do |tesla_model|
      tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/model-x.png')), filename: 'model-x.png', content_type: 'image/png')
    end

TeslaModel.create(
  name: "Model Y",
  description: "SHATTER-RESISTANT ARMOR GLASS CAN RESIST THE IMPACT OF A BASEBALL AT 112 KM/H OR CLASS 4 HAIL. ACOUSTIC GLASS HELPS MAKE THE CABIN AS QUIET AS OUTER SPACE",
  deposit: 134,
  finance_fee: 2323,
  option_to_purchase_fee: 431232,
  total_amount_payable: 32324,
  duration: 12,
  removed: false,
).tap do |tesla_model|
  tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/model-y.jpeg')), filename: 'model-y.jpeg', content_type: 'image/jpeg')
end

TeslaModel.create(
  name: "Cyber Truck",
  description: "SHATTER-RESISTANT ARMOR GLASS CAN RESIST THE IMPACT OF A BASEBALL AT 112 KM/H OR CLASS 4 HAIL. ACOUSTIC GLASS HELPS MAKE THE CABIN AS QUIET AS OUTER SPACE",
  deposit: 134,
  finance_fee: 2323,
  option_to_purchase_fee: 431232,
  total_amount_payable: 32324,
  duration: 12,
  removed: false,
).tap do |tesla_model|
  tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/cybertruck.jpeg')), filename: 'cybertruck.jpeg', content_type: 'image/jpeg')
end
