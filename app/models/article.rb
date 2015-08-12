class Article < ActiveRecord::Base
  belongs_to :order
  belongs_to :category
  has_many :order_items

  scope :filter, ->(id){where('category_id = ?', id) if id.present?}

  acts_as_votable
  validates :name, presence: true
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    :numericality => {:greater_than => 0, :less_than => 1000}
  validates :description, presence: true
  validates :category_id, presence: true 

end
