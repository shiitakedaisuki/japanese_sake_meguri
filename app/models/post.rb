class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def get_image(width, height)
    if image.attached?
      image.variant(resize_to_limit: [width, height]).processed
    # プロフィール写真が添付されていない場合
    else
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      # variantで画像を表示する処理を行う。
      image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
  # ユーザidがFavoritesテーブル内に存在（exists?）するか確認。存在しなければfalseを返す
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
