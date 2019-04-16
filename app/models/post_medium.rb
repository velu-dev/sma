class PostMedium < ApplicationRecord
  mount_uploader :media, PostimgUploader
  belongs_to :post, optional: true
end
