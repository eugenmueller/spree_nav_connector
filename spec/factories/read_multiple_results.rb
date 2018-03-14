FactoryBot.define do
  factory :read_multiple_result, class: OpenStruct do
    code 200
    headers {}
    trait :default do
      body do
        { read_multiple_result: { read_multiple_result: { partner01_item: create_list(:item, 3) } } }
      end
    end

    trait :part_1 do
      body do
        { read_multiple_result: { read_multiple_result: { partner01_item: create_list(:item, 2) } } }
      end
    end

    trait :part_2 do
      body do
        { read_multiple_result: { read_multiple_result: { partner01_item: create_list(:item, 1) } } }
      end
    end
  end
end
