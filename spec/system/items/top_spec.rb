require 'rails_helper'

RSpec.describe 'items#top', type: :system do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:item) { create(:item, user: user) }

  context "ログイン前" do
    before do
      visit root_path
    end

    it 'いいねアイコンをクリックするとログイン画面へ遷移する' do
      within("#likes-#{item.id}") do
        find('.like-button').click
        expect(current_path).to eq new_user_session_path
      end
    end

    it 'コメントアイコンをクリックするとログイン画面へ遷移する' do
      find('.comment-button', match: :first).click
      expect(current_path).to eq new_user_session_path
    end
  end

  context "ログイン後" do
    before do
      sign_in user
      visit root_path
    end

    it 'いいねアイコンをクリックするといいねアイコンが紺色に変化しいいね数が+1される、さらにいいねアイコンをクリックするとアイコンが白色に戻りいいね数が-1される', js: true do

      within("#likes-#{item.id}") do
        expect(find('.like-button i')['class']).to include('far')
        expect(find('.like-button i')['class']).not_to include('fas')
        expect(find('.like-button').text.to_i).to eq 0

        find('.like-button').click
        wait_for_ajax

        expect(page).to have_css('.like-button i.fas')
        expect(find('.like-button i')['class']).to include('fas')
        expect(find('.like-button i')['class']).not_to include('far')
        expect(find('.like-button').text.to_i).to eq 1

        find('.like-button').click
        wait_for_ajax

        # find('.like-button i.far')
        expect(page).to have_css('.like-button i.far')
        expect(find('.like-button i')['class']).to include('far')
        expect(find('.like-button i')['class']).not_to include('fas')
        expect(find('.like-button').text.to_i).to eq 0
      end
    end

    it 'いいねアイコンをクリックすると、その投稿のいいねしたユーザー一覧ページにいいねしたユーザーが追加されている。再度いいねアイコンをクリックすると、その投稿のいいねしたユーザー一覧ページからいいねを解除したユーザーが削除されている', js: true do
      within("#likes-#{item.id}") do
        find('.like-button').click
      end
      visit liked_users_item_path(item)
      expect(page).to have_content(user.name)

      visit root_path
      within("#likes-#{item.id}") do
        find('.like-button').click
      end
      visit liked_users_item_path(item)
      expect(page).not_to have_content(user.name)
    end

    it 'コメントアイコンをクリックすると、コメント一覧ページへ遷移する' do
      within("#comments-#{item.id}") do
        find('.comment-button').click
        expect(current_path).to eq item_comments_path(item)
      end
    end
  end
end
