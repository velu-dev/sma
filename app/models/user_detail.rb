class UserDetail < ApplicationRecord
  mount_uploader :profile_pic, ProfileimgUploader
  belongs_to :user
end