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

  it 'expect to be invalid with nil-article' do
    orderItem = build(:order_item, article: nil)
    expect(orderItem).not_to be_valid
  end

  it 'expect to be valid with normal article' do
    orderItem = build(:order_item)
    expect(orderItem).to be_valid
  end

  it 'expect not to be valid with nil-order' do
    orderItem = build(:order_item)
    expect(orderItem).not_to be_valid
  end
 
  it 'expect to be valid with normal order' do
    orderItem = build(:order_item)
    expect(orderItem).to be_valid
  end
end

