FactoryBot.define do
  factory :item, class: OpenStruct do
    sequence(:key) { |n| "key_#{n}" }
    name { FFaker::Product.product }
  end
end
