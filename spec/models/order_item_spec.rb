require 'rails_helper'

describe OrderItem do 
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
