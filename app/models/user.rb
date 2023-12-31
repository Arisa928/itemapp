class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  MAX_USER_NAME_LENGTH = 20

  has_many :items, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: MAX_USER_NAME_LENGTH }, uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :timeoutable

  # ゲストユーザーの作成
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.avatar.attach(io: File.open('app/assets/images/default_icon_image.png'), filename: 'default_icon_image.png', content_type: 'image/png')
    end
  end

  # ゲストユーザーかどうか判断するメソッド
  def guest?
    email == 'guest@example.com'
  end

  # パスワードなしでユーザーが自分のアカウントを更新できるようにする
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  # 検索対象カラムの設定
  def self.ransackable_attributes(auth_object = nil)
    %w(name introduction)
  end

  # 検索対象の関連テーブルの設定
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
