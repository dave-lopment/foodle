class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates :name, presence: true, allow_blank: false
  validates :email_address, uniqueness: true, presence: true,
    allow_blank: false, format: {with: VALID_EMAIL_REGEX }
  validates :postal, length: { is: 5 }
  validates :city, presence: true, allow_blank: false
  validates :street, presence: true, allow_blank: false

  #before_save :set_default_admin
  
  #def set_default_admin
   # self.admin = self.admin ||= false
  #end 
end
