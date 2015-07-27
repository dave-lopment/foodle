class User < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false
  validates :email_address, uniqueness: true, presence: true, allow_blank: false 
  validates :postal, length: { is: 5 }
  validates :city, presence: true, allow_blank: false
  validates :street, presence: true, allow_blank: false
end
