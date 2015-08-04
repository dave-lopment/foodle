class OrderItem < ActiveRecord::Base
  belongs_to :article
  belongs_to :order
end
