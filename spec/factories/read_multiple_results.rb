def create_item_list(count)
  {
    read_multiple_result: {
      read_multiple_result: {
        partner01_item: build_list(:raw_navision_item, count).map(&:to_h)
      }
    }
  }
end

FactoryBot.define do
  factory :read_multiple_result, class: OpenStruct do
    code 200
    headers {}
    trait :default do
      body { create_item_list(3) }
    end

    trait :part_1 do
      body { create_item_list(2) }
    end

    trait :part_2 do
      body { create_item_list(1) }
    end
  end

  factory :read_multiple_empty_result, class: OpenStruct do
    code 200
    headers {}
    body nil
  end
end
