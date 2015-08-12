FactoryGirl.define do
  factory :order_item do
    article {create(:article)}
    order {create(:order)}
    unit_price nil
    quantity 1
  end

end
