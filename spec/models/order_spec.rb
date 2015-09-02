require 'rails_helper'

RSpec.describe Order, type: :model do

  context 'Order Tests' do
  
    it 'expect count of different elements to be correct' do
      orderItem1 = FactoryGirl.create(:order_item)
      orderItem2 = FactoryGirl.create(:order_item, quantity: 3)
      order = FactoryGirl.create(:order, order_items: [orderItem1, orderItem2])
      expect(order.count).to be_equal(4)
    end
  
    it 'expect count of elements with higher quantity then 1 to be correct' do
      orderItem1 = FactoryGirl.create(:order_item, quantity: 5)
      order = FactoryGirl.create(:order, order_items: [orderItem1])
      expect(order.count).to be_equal(5)
    end
  
    it 'expect order_status not to be nil' do
      order = Order.create()
      expect(order[:order_status]).not_to be_nil
    end
  
  end
end
