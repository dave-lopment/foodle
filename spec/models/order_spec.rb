require 'rails_helper'

RSpec.describe Order, type: :model do

  context 'Order Tests' do
    it 'expect subtotal with quantity 1 to be correct'#do
     # orderItem1 = FactoryGirl.create(:order_item,{quantity: 1, unit_price: 2.0})
     # order = FactoryGirl.create(:order, order_items: [orderItem1])
     # expect(order.subtotal).to be_equal(2.0)
   # end
  
    it 'expect count of different elements to be correct' do
      orderItem1 = FactoryGirl.create(:order_item)
      orderItem2 = FactoryGirl.create(:order_item, quantity: 3)
      order = FactoryGirl.create(:order, order_items: [orderItem1, orderItem2])
      expect(order.count).to be_equal(4)
    end
  
    it 'expect count of elements with higher quantity then 1 to be correct' do
     # orderStatus = FactoryGirl.create(:order_status)
      orderItem1 = FactoryGirl.create(:order_item, quantity: 5)
      order = FactoryGirl.create(:order, order_items: [orderItem1])
      expect(order.count).to be_equal(5)
    end
  
    it 'expect order_status not to be nil' do
     # orderStatus = FactoryGirl.create(:order_status)
      order = Order.create()
      expect(order[:order_status]).not_to be_nil
    end
  
    it 'expect subtotal updated after save'
  end
end
