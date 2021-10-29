FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    description { Faker::Company.buzzword }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    association :merchant
  end
end
