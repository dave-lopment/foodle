class Article < ActiveRecord::Base
  acts_as_votable
  belongs_to :order
  belongs_to :category
  has_many :order_items
  mount_uploader :img_name, PictureUploader

  scope :filter, ->(id){where('category_id = ?', id) if id.present?}

  acts_as_votable
  validates :name, presence: true
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ },
    :numericality => {:greater_than => 0, :less_than => 1000}
  validates :description, presence: true
  validates :category_id, presence: true
  validate :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if img_name.size > 5.megabytes
        errors.add(:img_name, "should be less than 5MB")
      end
    end


end
