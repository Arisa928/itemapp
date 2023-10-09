require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe '.guest' do
    subject { User.guest }

    it 'creates a guest user with the guest email' do
      expect(subject.email).to eq 'guest@example.com'
    end

    it 'creates a guest user with a name "ゲスト"' do
      expect(subject.name).to eq 'ゲスト'
    end

    it 'creates a guest user with an avatar image' do
      expect(subject.avatar).to be_attached
    end
  end

  describe '#update_without_current_password' do
    let(:params) { { name: 'Updated Name' } }

    it 'updates the user without the current password' do
      expect(user.update_without_current_password(params)).to be_truthy
      expect(user.reload.name).to eq 'Updated Name'
    end
  end
end
