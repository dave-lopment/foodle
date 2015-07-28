class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates :name, presence: true, allow_blank: false
  validates :email_address, uniqueness: true, presence: true,
    allow_blank: false, format: {with: VALID_EMAIL_REGEX }
  validates :postal, length: { is: 5 }
  validates :city, presence: true, allow_blank: false
  validates :street, presence: true, allow_blank: false
end
