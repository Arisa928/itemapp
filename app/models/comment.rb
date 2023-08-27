class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :content, presence: true, length: { minimum: 1, maximum: 400 }
  validates :user_id, presence: true
  validates :item_id, presence: true
end
