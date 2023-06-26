class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :profile_image
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :user_name, presence: true
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      # ↓SecureRandom.urlsafe_base64でパスワードをランダムに生成してくれている
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲストユーザー"
    end
  end
  
  def get_profile_image(width, height)
    # プロフィール写真が添付されている場合
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    # プロフィール写真が添付されていない場合
    else
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/*')
      # variantで画像を表示する処理を行う。
      profile_image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @users = User.where("user_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @users = User.where("user_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @users = User.where("user_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @users = User.where("user_name LIKE?","%#{word}%")
    else
      @users = User.all
    end
  end
end
