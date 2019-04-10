class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :senders, :class_name => "Friendlist", foreign_key: "sender_id"
  has_many :recipients, :class_name => "Friendlist", foreign_key: "recipient_id"
  has_many :sentbys, :class_name => "Notifications", foreign_key: "sentby_id"
  has_many :receivedbys, :class_name => "Notifications", foreign_key: "receivedby_id"
  has_many :first_users, :class_name => "ChatRoom", foreign_key: "first_user_id"
  has_many :second_users, :class_name => "ChatRoom", foreign_key: "second_user_id"
  has_one :user_detail
end
