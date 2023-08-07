FactoryBot.define do
  factory :user do
    name { "MyString" }
    introduction { "MyText" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end
