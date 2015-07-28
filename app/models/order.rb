class Order < ActiveRecord::Base
  belongs_to :user
  has_many :articles
  
  validates :date_sent, presence: true
end
