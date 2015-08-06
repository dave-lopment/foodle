FactoryGirl.define do
  factory :article do
    sequence(:name) { |i| "Artikel#{i}"}
    sequence(:price) { |i| "#{i}.99"}
    isVegetarian false
    description "What a wonderful article"
  end

  trait :fresh_article do
    name nil
    description nil
    price nil
    isVegetarian nil
  end

end
