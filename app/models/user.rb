class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_one_attached :profile_image
  
  def get_profile_image(width, height)
    # プロフィール写真が添付されている場合
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    # プロフィール写真が添付されていない場合
    else
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      # variantで画像を表示する処理を行う。
      profile_image.variant(resize_to_limit: [width, height]).processed
    end
  end
end
