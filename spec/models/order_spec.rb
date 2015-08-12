require 'rails_helper'

RSpec.describe Order, type: :model do

  it 'expect subtotal with quantity 1 to be correct'

  it 'expect count of different elements to be correct'

  it 'expect count of elements with higher quantity then 1 to be correct'

  it 'expect order_status not to be nil' do
    order = Order.create()
    expect(order[:order_status_id]).not_to be_nil
  end

  it 'expect subtotal updated after save'

end
