FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "Kategorie#{i}" }
  end

end
