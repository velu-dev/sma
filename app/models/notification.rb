class Notification < ApplicationRecord
  belongs_to :like, :optional => true
  belongs_to :comment, :optional => true
  belongs_to :post, :optional => true
  belongs_to :receivedby, :class_name => "User"
  belongs_to :sentby, :class_name => "User"
  belongs_to :notify_type
end
