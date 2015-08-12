class Category < ActiveRecord::Base
  has_many :articles, dependent: :destroy 
  validates :name, presence: true, length: { maximum: 32 }
end
