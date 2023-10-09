require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }

  describe '#liked_by?' do

    context 'いいねされている時' do
      before { create(:like, user: user, item: item) }

      it 'returns true' do
        expect(item.liked_by?(user)).to be true
      end
    end

    context 'いいねされていない場合' do
      it 'returns false' do
        expect(item.liked_by?(user)).to be false
      end
    end
  end
end
