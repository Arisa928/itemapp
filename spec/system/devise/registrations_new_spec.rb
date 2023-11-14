require 'rails_helper'

RSpec.describe "User registration", type: :system do
  let(:user) { build(:user) } # ファクトリボット等を使用してユーザーデータを準備

  context 'フォームの入力値が正常' do
    it 'ユーザー新規登録が成功する' do
      visit new_user_registration_path

      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password_confirmation
      click_button '登録'

      expect(page).to have_content 'アカウント登録が完了しました。'
    end
  end

  context 'フォームの入力値が異常' do
    it 'ユーザー新規登録が失敗し、エラーメッセージが表示される' do
      visit new_user_registration_path

      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      click_button '登録'

      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'パスワードを入力してください'
    end
  end

  context "登録済のメールアドレスを使用" do
    it 'ユーザー新規登録が失敗し、エラーメッセージが表示される' do
      existed_user = create(:user)
      visit new_user_registration_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: existed_user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password_confirmation
      click_button '登録'
      expect(page).to have_content 'メールアドレスはすでに使用されています'
      expect(page).to have_field 'メールアドレス', with: existed_user.email
    end
  end
end
