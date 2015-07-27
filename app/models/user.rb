class User < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false
  validates :email_adress, uniqueness: true 
end
