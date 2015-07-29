class Article < ActiveRecord::Base
  belongs_to :order
  belongs_to :category

  acts_as_votable
  validates :name, presence: true
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    :numericality => {:greater_than => 0, :less_than => 1000}
  validates :description, presence: true 
end
