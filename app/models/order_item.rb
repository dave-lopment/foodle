class OrderItem < ActiveRecord::Base
  belongs_to :article
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :article_present
  
  private
    
    def article_present
      if article.nil?
        errors.add(:product, "is not valid or is not active.")
      end
    end

end
