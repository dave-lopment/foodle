class Article < ActiveRecord::Base
  validates :name, presence: true
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    :numericality => {:greater_than => 0, :less_than => 1000}
end
