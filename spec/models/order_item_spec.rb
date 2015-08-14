require 'rails_helper'

describe OrderItem do
  
  context "Quantity Attribute Tests" do
    it 'expect to be invalid with quantity equal to zero' do
      orderItem = build(:order_item, quantity: 0)
      expect(orderItem).not_to be_valid
    end
 
    it 'expect to be invalid with quantity nil' do
      orderItem = build(:order_item, quantity: nil)
      expect(orderItem).not_to be_valid
    end
 
    it 'expect to be valid with normal quantity' do
      orderItem = build(:order_item)
      expect(orderItem).to be_valid
    end
  end

  context "Article Attribute Tests" do
    it 'expect to be invalid with nil-article' do
      orderItem = build(:order_item, article: nil)
      expect(orderItem).not_to be_valid
    end
 
    it 'expect to be valid with normal article' do
      orderItem = build(:order_item)
      expect(orderItem).to be_valid
    end
  end

  context "Order Attribute Tests" do
    it 'expect not to be valid with nil-order' do
      orderItem = build(:order_item, order: nil)
      expect(orderItem).not_to be_valid
    end
  
    it 'expect to be valid with normal order' do
      orderItem = build(:order_item)
      expect(orderItem).to be_valid
    end
  end

  context "Order_Item Method Tests" do
    it 'expect order_item.unit_price to be article.price after call of unit_price-method' do
      orderItem = build(:order_item)
      orderItem.unit_price()
      expect(orderItem.unit_price).to be_equal(orderItem.article.price)
    end
 
    it 'expect order_item.total_price to be equal to quantity * unit_price after call of total_price-method' do
      orderItem = build(:order_item, quantity: 3)
      orderItem.total_price()
      expect(orderItem.total_price).to be_within(0.0).of(orderItem.unit_price * orderItem.quantity)
    end
 
    it 'expect unit price not to be nil after save -> finalize method' do
      orderItem = build(:order_item)
      expect(orderItem[:unit_price]).to be_nil
      orderItem.save()
      expect(orderItem[:unit_price]).not_to be_nil
    end
 
    it 'expect total_price not to be nil after save -> finalize method' do
      orderItem = build(:order_item, quantity: 3)
      expect(orderItem[:total_price]).to be_nil
      orderItem.save()
      expect(orderItem[:total_price]).not_to be_nil
    end
  end

end

