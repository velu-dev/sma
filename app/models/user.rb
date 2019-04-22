class User < ApplicationRecord
  before_save :encrypt_password
  after_save :clear_password

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

  def encrypt_password
    if password.present?
      encrypt = VeEncrypt.new(password)
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end
end
