class UserDetail < ApplicationRecord
  mount_base64_uploader :profile_pic, ProfileimgUploader
  mount_uploader :cover_pic, ProfileimgUploader
  belongs_to :user
end
