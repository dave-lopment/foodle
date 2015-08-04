class OrderItem < ActiveRecord::Base
  belongs_to :article
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :article_present
  validate :order_present  
  private
    
    def article_present
      if article.nil?
        errors.add(:product, "is not valid or is not active.")
      end
    end

    def order_present
      if order.nil?
        errors.add(:order, "is not a valid order.")
      end
    end
end
