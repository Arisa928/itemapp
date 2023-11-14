FactoryBot.define do
  factory :item do
    user
    sequence(:name) { |n| ('a'.ord + (n - 1) % 26).chr + "_item" }
    category_list { Faker::Commerce.department(max: 3) }
    detail { Faker::Lorem.sentence }
    sequence(:created_at) { |n| Time.current - n.hours }

    # itemにlikeを紐づける
    transient do
      likes_count { 0 }
    end

    after(:create) do |item, evaluator|
      evaluator.likes_count.times do
        create(:like, item: item, user: create(:user))
      end
    end

    # itemに画像を添付する
    after(:create) do |item|
      image_path = Rails.root.join('spec', 'support', 'assets', 'test_item_image.jpg')
      item.image.attach(io: File.open(image_path), filename: 'test_item_image.jpg', content_type: 'image/jpeg')
    end
  end
end
