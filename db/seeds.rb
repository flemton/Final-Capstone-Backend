TeslaModel.create(
        name: "Model 3",
        description: "This is a mid-size all-electric four-door seda.",
        deposit: 3432,
        finance_fee: 524,
        option_to_purchase_fee: 3253,
        total_amount_payable: 535325,
        duration: 3,
        removed: false,
    ).tap do |tesla_model|
      tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/Tesla1.jpeg')), filename: 'Tesla1.jpeg', content_type: 'image/png')
    end

TeslaModel.create(
  name: "Model Y",
  description: "The Model Y is a mid-size all-electric crossover.",
  deposit: 134,
  finance_fee: 2323,
  option_to_purchase_fee: 431232,
  total_amount_payable: 32324,
  duration: 12,
  removed: false,
).tap do |tesla_model|
  tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/Tesla3.jpeg')), filename: 'Tesla3.jpeg', content_type: 'image/jpeg')
end

TeslaModel.create(
  name: "Model X",
  description: "The Model X is a mid-size all-electric luxury automobile.",
  deposit: 134,
  finance_fee: 2323,
  option_to_purchase_fee: 431232,
  total_amount_payable: 32324,
  duration: 12,
  removed: false,
).tap do |tesla_model|
  tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/Tesla4.jpg')), filename: 'Tesla4.jpg', content_type: 'image/jpeg')
end

TeslaModel.create(
  name: "Cyber Truck",
  description: "This is all-electric commercial vehicle in development.",
  deposit: 134,
  finance_fee: 2323,
  option_to_purchase_fee: 431232,
  total_amount_payable: 32324,
  duration: 12,
  removed: false,
).tap do |tesla_model|
  tesla_model.image.attach(io: File.open(Rails.root.join('db/seed-images/Tesla.jpg')), filename: 'Tesla.jpg', content_type: 'image/jpeg')
end
