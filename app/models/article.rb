class Article < ActiveRecord::Base
  validates :name, presence: true
  validates :price, :numericality => {:greater_than => 0, :less_than => 1000}
end
