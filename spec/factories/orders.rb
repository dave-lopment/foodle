FactoryGirl.define do
  factory :order do
    subtotal "9.99"
    tax "9.99"
    shipping "9.99"
    total "9.99"
    street "Die Opferstr. 50"
    postal 12345
    city "St. Kevinston"
    order_status 0
  end

end
