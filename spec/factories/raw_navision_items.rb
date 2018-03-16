FactoryBot.define do
  factory :raw_navision_item, class: OpenStruct do
    sequence(:key) { |n| "key_#{n}" }
    rec_id 'MyString'
    sequence(:no)
    description 'MyString'
    description_2 'MyString'
    long_text 'MyString'
    base_unit_of_measure 'MyString'
    item_category_code 'MyString'
    product_group_code 'MyString'
    group_of_goods_code 'MyString'
    vat_bus_posting_gr_price 'MyString'
    vat_prod_posting_group 'MyString'
    blocked false
    eol 'MyString'
    manufacturer_item_no_1 'MyString'
    manufacturer_item_no_2 'MyString'
    manufacturer_code 'MyString'
    net_weight '9.99'
    gross_weight '9.99'
    webshop_release false
    wg0 '123'
    wg5 '234'
  end
end
