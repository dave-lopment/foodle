FactoryGirl.define do
  factory :article do
    sequence(:name) { |i| "Artikel#{i}"}
    sequence(:price) { |i| "#{i}.99"}
    isVegetarian false
    description "What a wonderful article"
  end

  trait :invalid_article_attributes do
    name ''
    price 2.234
    description ''
  end

end
