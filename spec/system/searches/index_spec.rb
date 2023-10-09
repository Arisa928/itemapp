require 'rails_helper'

RSpec.describe "Searches", type: :system do
  let!(:user1) { create(:user, name: '山田太郎', introduction: 'おはようございます') }
  let!(:user2) { create(:user, name: '田中太郎', introduction: 'こんにちは') }
  let!(:user3) { create(:user, name: '山田花子', introduction: 'こんばんは') }
  let!(:item1) { create(:item, name: 'logicool G600', detail: '多ボタンマウス', category_list: 'マウス') }
  let!(:item2) { create(:item, name: '蒸気でホットアイマスク', detail: '疲れ目に有効なアイマスク', category_list: 'その他') }
  let!(:item3) { create(:item, name: 'KrakenGreen', detail: '音声がクリアなヘッドセット', category_list: 'ヘッドセット') }

  it '検索キーワードとアイテム名が部分一致するアイテムが”投稿”タブに表示される（一致しないアイテムが表示されていない）' do
    visit searches_path
    fill_in 'q', with: 'G600'
    click_button '検索'
    within('#search-result') do
      expect(page).to have_content(item1.name)
      expect(page).not_to have_content(item2.name)
      expect(page).not_to have_content(item3.name)
    end
  end

  it '検索キーワードとitemの詳細が部分一致するitemが”投稿”タブに表示される（一致しないitemが表示されていない）' do
    visit searches_path
    fill_in 'q', with: '多ボタン'
    click_button '検索'
    within('#search-result') do
      expect(page).to have_content(item1.name)
      expect(page).not_to have_content(item2.name)
      expect(page).not_to have_content(item3.name)
    end
  end

  it '検索キーワードとカテゴリー名が完全一致するitemが”カテゴリー”タブに表示される（一致しないitemが表示されていない）', js: true do
    visit searches_path
    fill_in 'q', with: 'ヘッドセット'
    click_button '検索'
    click_link 'カテゴリー'
    within('#search-result') do
      expect(page).not_to have_content(item1.name)
      expect(page).not_to have_content(item2.name)
      expect(page).to have_content(item3.name)
    end
  end

  it '検索キーワードとユーザー名が部分一致するユーザーが”ユーザー”タブに表示される（一致しないユーザーが表示されていない）', js: true do
    visit searches_path
    fill_in 'q', with: '太郎'
    click_button '検索'
    click_link 'ユーザー'
    within('#search-result') do
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
      expect(page).not_to have_content(user3.name)
    end
  end

  it '検索キーワードとユーザーの自己紹介が部分一致するユーザーが”ユーザー”タブに表示される（一致しないユーザーが表示されていない）', js: true do
    visit searches_path
    fill_in 'q', with: 'おはようございます'
    click_button '検索'
    click_link 'ユーザー'
    within('#search-result') do
      expect(page).to have_content(user1.name)
      expect(page).not_to have_content(user2.name)
      expect(page).not_to have_content(user3.name)
    end
  end

  it '一致する検索結果がない場合にメッセージを表示する' do
    visit searches_path
    fill_in 'q', with: 'キーボード'
    click_button '検索'
    expect(page).to have_content('条件に一致する検索結果はありません。')
  end

  it 'ユーザータブを選択し新規キーワードにて検索ボタンを押下後、キーワードに一致するユーザーが”ユーザー”タブに表示される（”投稿”タブに戻らない）', js: true do
    visit searches_path
    click_link 'ユーザー'
    fill_in 'q', with: '太郎'
    click_button '検索'
    within('#search-result') do
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
      expect(page).not_to have_content(user3.name)
    end
    expect(page).to have_css('#item-link.inactive-link')
    expect(page).to have_css('#user-link.active-link')
    expect(page).to have_css('#category-link.inactive-link')
  end

  it 'トップページの検索欄で未入力のまま検索ボタン押下後、検索結果ページにて投稿タブが太字、下線ありの装飾が適用されている' do
    visit root_path
    click_button '検索'
    expect(page).to have_css('#item-link.active-link')
    expect(page).to have_css('#user-link.inactive-link')
    expect(page).to have_css('#category-link.inactive-link')
  end

  it 'トップページの新着投稿欄のカテゴリータグをクリックすると検索結果ページのカテゴリータブに遷移し、選択したカテゴリーと同一カテゴリーの投稿一覧が表示される', js: true do
    visit root_path
    click_link 'マウス', match: :first
    expect(page).to have_title('検索結果')
    expect(page).to have_css('#item-link.inactive-link')
    expect(page).to have_css('#user-link.inactive-link')
    expect(page).to have_css('#category-link.active-link')
    within('#search-result') do
      expect(page).to have_content(item1.name)
      expect(page).not_to have_content(item2.name)
      expect(page).not_to have_content(item3.name)
    end
  end
end
