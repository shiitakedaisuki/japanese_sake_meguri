class Genre < ApplicationRecord
  has_many :post_genres, dependent: :destroy
  # 中間テーブルを通してpostモデルをhas_manyで持つ
  has_many :posts,through: :post_genres,source: :post
end
