module ApplicationHelper
  def user_avatar_image_tag(user, options = {})
    if user.avatar.attached?
      image_tag user.avatar, options
    else
      image_tag "default_icon_image.png", options
    end
  end

  def default_meta_tags
    {
      site: 'Gamers Item',
      title: 'ゲーマーにおすすめのアイテムを共有できるサービス',
      reverse: true,
      separator: '|',
      description: 'Gamers Itemは、ゲーマーにおすすめのアイテムを共有できるサービスです。',
      keywords: 'Gamers Item, Gamer, ゲーマー',
      charset: 'UTF-8',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.png'), sizes: '32x32' },
        { href: image_url('icon_logo.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: 'Gamers Item',
        title: 'ゲーマーにおすすめのアイテムを共有できるサービス',
        description: '「Gamers Item」は、ゲーマーにおすすめのアイテムを共有できるサービスです。',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
    }
  end
end
