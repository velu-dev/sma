class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_mediums, dependent: :destroy
  has_many :notifications

  # class Post
  Post.per_page = 2
  # end

  WillPaginate.per_page = 2
end
