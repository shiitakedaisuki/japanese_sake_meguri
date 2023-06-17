class Genre < ApplicationRecord
  has_many :post_genres, dependent: :destroy
end
