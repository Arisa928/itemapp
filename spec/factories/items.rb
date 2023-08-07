FactoryBot.define do
  factory :item do
    name { "MyString" }
    start_date { "2023-08-07" }
    category { "MyString" }
    detail { "MyText" }
    user_id { "" }
    rakuten_url { "MyString" }
  end
end
