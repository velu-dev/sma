class PostMedium < ApplicationRecord
  mount_uploader :media, PostimgUploader
  belongs_to :post, optional: true
  process_in_background :media
end
