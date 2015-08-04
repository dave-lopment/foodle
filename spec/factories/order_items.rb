FactoryGirl.define do
  factory :order_item do
    article {create(:article)}
    order nil
    unit_price "9.99"
    quantity 1
    total_price "9.99"
  end

end
