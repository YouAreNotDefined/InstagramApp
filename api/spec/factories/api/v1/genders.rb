FactoryBot.define do
  factory :api_v1_gender, class: 'Api::V1::Gender' do
    type { 1 }
    detail { "MyString" }
  end
end
