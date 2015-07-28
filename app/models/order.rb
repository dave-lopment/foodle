class Order < ActiveRecord::Base
  validates :date_sent, presence: true
end
