require 'rails_helper'

RSpec.describe "items", type: :system do
  let!(:user) { create(:user) }

  context "ページネーションなし" do
    let!(:items) do
      [
        create(:item, created_at: 3.hours.ago, likes_count: 5, name: "c_item", category_list: ["マウス", "ゲーミングマウス"]),
        create(:item, created_at: 2.hours.ago, likes_count: 3, name: "D_item", category_list: ["ヘッドセット", "無線ヘッドセット"]),
        create(:item, created_at: 1.hour.ago, likes_count: 10, name: "f_item", category_list: ["キーボード", "赤軸キーボード"]),
      ]
    end

    before do
      sign_in user
      visit items_path
    end

    it "並び替えボタンをクリックするとドロップダウンが展開し”新着順”に背景色が設定されている", js: true do
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#new_order.active")
      end
    end

    it "投稿一覧ページ遷移時は、新着順に投稿が表示されている", js: true do
      displayed_items = all('.post-container')
      expect(displayed_items.first).to have_content items.last.name
      expect(displayed_items.last).to have_content items.first.name
    end

    it "”人気順”から”新着順”を選択すると新着順に表示される", js: true do
      find('#dropdownMenuButton1').click
      click_on '人気順'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      click_on '新着順'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#new_order.active")
      end
      wait_for_ajax
      find('#dropdownMenuButton1').click
      wait_for_ajax

      displayed_items = all('.post-container')
      expect(displayed_items.first).to have_content items.last.name
      expect(displayed_items.last).to have_content items.first.name
    end

    it "”古い順を選択すると古い順に表示される”", js: true do
      find('#dropdownMenuButton1').click
      click_on '古い順'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#older_order.active")
      end
      wait_for_ajax
      find('#dropdownMenuButton1').click
      wait_for_ajax

      displayed_items = all('.post-container')
      expect(displayed_items.first).to have_content items.first.name
      expect(displayed_items.last).to have_content items.last.name
    end

    it "”人気順”を選択するといいね数が多い順に並び替えられ、新着順の背景色がなくなり、選択した人気順に背景色が適用される。", js: true do
      find('#dropdownMenuButton1').click
      click_on '人気順'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#ranking_order.active")
      end
      wait_for_ajax
      find('#dropdownMenuButton1').click
      wait_for_ajax

      displayed_items = all('.post-container')
      expect(displayed_items.first).to have_content items[2].name
      expect(displayed_items.last).to have_content items[1].name
    end

    it "昇順(アイテム名)を選択すると、大小文字関係なくアルファベット順に表示される", js: true do
      find('#dropdownMenuButton1').click
      click_on '昇順(アイテム名)'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#name_asc_order.active")
      end
      wait_for_ajax
      find('#dropdownMenuButton1').click
      wait_for_ajax

      displayed_items = all('.post-container')
      expect(displayed_items.first).to have_content items[0].name
      expect(displayed_items.last).to have_content items[2].name
    end

    it "降順(アイテム名)を選択すると、大小文字関係なくアルファベット逆順に表示される", js: true do
      find('#dropdownMenuButton1').click
      click_on '降順(アイテム名)'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#name_desc_order.active")
      end
      wait_for_ajax
      find('#dropdownMenuButton1').click
      wait_for_ajax

      displayed_items = all('.post-container')
      expect(displayed_items.first).to have_content items[2].name
      expect(displayed_items.last).to have_content items[0].name
    end

  end

  context "ページネーションあり" do
    let!(:items) { create_list(:item, 26, user: user) }

    before do
      sign_in user
      visit items_path
    end

    it "投稿数が25以上の場合、ページネーションが表示され2ページ目をクリックすると、新着順のまま2ページ目へ遷移する", js: true do
      wait_for_ajax
      expect(page).to have_css('.pagination')

      # １ページ目の最後のアイテムを取得
      first_page_last_item = all('.post-container').last
      new_item = first_page_last_item.find('.item-name').text
      first_page_last_item_created_at = Item.find_by(name: new_item).created_at # １ページ目の最後のアイテムの作成日時を取得

      element = find('.pagination .page-item:nth-child(2) a')
      page.execute_script("arguments[0].scrollIntoView(true)", element.native)
      element.click
      wait_for_ajax
      expect(page).not_to have_content(first_page_last_item.text)

      # ２ページ目の最後のアイテムを取得
      second_page_first_item = all('.post-container').first
      older_item = second_page_first_item.find('.item-name').text
      second_page_first_item_created_at = Item.find_by(name: older_item).created_at # １ページ目の最後のアイテムの作成日時を取得
      expect(second_page_first_item_created_at).to be < first_page_last_item_created_at
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#new_order.active")
      end
    end

    it "投稿数が25以上の場合、昇順(アイテム名)を選択し2ページ目をクリックすると、昇順(アイテム名)のまま2ページ目へ遷移する", js: true do
      wait_for_ajax
      expect(page).to have_css('.pagination')
      find('#dropdownMenuButton1').click
      click_on '昇順(アイテム名)'
      wait_for_ajax
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#name_asc_order.active")
      end
      wait_for_ajax
      find('#dropdownMenuButton1').click
      wait_for_ajax

      # １ページ目の最後のアイテムを取得
      first_page_last_item = all('.post-container').last
      new_item = first_page_last_item.find('.item-name').text
      wait_for_ajax
      element = find('.pagination .page-item:nth-child(2) a')
      page.execute_script("arguments[0].scrollIntoView(true)", element.native)
      element.click
      wait_for_ajax
      expect(page).not_to have_content(new_item)

      # ２ページ目の最後のアイテムを取得
      second_page_first_item = all('.post-container').first
      older_item = second_page_first_item.find('.item-name').text

      expect(older_item).to be > new_item
      find('#dropdownMenuButton1').click
      within("#dropdown_menu") do
        expect(page).to have_css("#name_asc_order.active")
      end
    end
  end
end
