<h1>作品</h1>
サイトURL : https://itemapp-6f9971ff2865.herokuapp.com/

TOPページ
<img width="1422" alt="スクリーンショット 2023-11-19 2 29 29" src="https://github.com/Arisa928/itemapp/assets/124275715/403786a0-540d-4875-9581-8eb376f8fa4e">

<h2>アプリについて</h2>

このアプリはゲーマーのためのおすすめ紹介アプリです。 <br>
ゲーマー目線のレビューが集まるツールがあればより楽しいゲーマーライフが送れるのではと考え作成しました。
マウスやマイク、キーボードなどゲームに使用するようなアイテムに関して実際の使用感を知ることでより自身の目的にあうものを購入できるように手助けします。 <br>
投稿者は楽天APIで商品の購入ページへのリンクを作成でき、閲覧者はそのリンクから商品購入ページへすぐにアクセスできます。 <br>

<h2>機能</h2>
・ユーザー登録/削除機能 <br>
・ログイン/ログアウト機能 <br>
・ゲストログイン機能 <br>
<img width="1382" alt="スクリーンショット 2023-11-16 1 02 04" src="https://github.com/Arisa928/itemapp/assets/124275715/d597aaa8-d6ce-479b-a053-2ea4caea22a3">

・ユーザー情報の表示/編集機能 <br>
・検索機能(ユーザー名、カテゴリー、商品名で検索可能) <br>
　カテゴリーをクリックすることでそのカテゴリーが付いた商品のみを一覧表示可能 <br>
・コメント機能 <br>
・いいね機能 <br>
・楽天市場の購入リンクの設定機能 <br>
    * 商品登録時にその商品の楽天市場での購入リンクを設定可能 <br>
    * 商品詳細ページにて楽天市場リンクをクリックすることでその商品の楽天市場ページへ遷移 <br>
・投稿一覧、ユーザー一覧ページでの並び替え機能 <br>
    * 新着順、古い順、人気順、ガジェット名、カテゴリー名での並び替えが可能 <br>
<img width="1381" alt="スクリーンショット 2023-11-16 1 00 35" src="https://github.com/Arisa928/itemapp/assets/124275715/adb562da-237d-42b6-b1e9-537bfa5dcb68">


<h2>使用技術</h2>
・ Ruby (3.2.2) <br>
・ Ruby on Rails (7.0.8) <br>
・ Bootstrap <br>
・ JavaScript <br>
・ Heroku <br>
・ AWS（S3） <br>
・ RakutenAPI <br>
・ Rspec <br>
・ Rubocop <br>


ER図
![ER図](https://github.com/Arisa928/itemapp/assets/124275715/0c5f90a0-6898-427a-bc5a-6c0c024adba8)

<h3>今後の課題</h3>
ユーザービリティ向上を考えた修正が課題です。<br>
具体的には、問い合わせフォームを実装しサイト上から問い合わせ出来る機能やいいねした投稿を一覧で見ることが出来る機能の追加、ゲーマー向けのアプリのため、どのジャンルのゲームで特に有用なのかパッと見てわかるようするなどユーザーが知りたい情報をより簡単な手順で得られるようにすることを考えています。
