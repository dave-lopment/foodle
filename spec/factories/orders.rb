FactoryGirl.define do
  factory :order do
    sequence(:date_sent) { Time.now }
    delivery_status false 
  end

end
