FactoryBot.define do
  factory :message, class: OpenStruct do
    filter {}
    bookmarkKey ''
    setSize 1000
  end
end
