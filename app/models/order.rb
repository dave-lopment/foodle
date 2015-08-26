class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  before_save :update_subtotal

  enum order_status: ['Erstellung','Auftrag','Abgeschickt','Angekommen','Storniert' ]
  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0}.sum
  end

  def count
    order_items.collect { |i| i.valid? ? (i.quantity) : 0}.sum
  end

  private
    def update_subtotal
      self[:subtotal] = subtotal
    end
end
