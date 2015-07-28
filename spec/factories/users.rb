# do -> gem install factory_girl
# add require 'factory_girl' to your test_helper.rb or spec_helper.rb

FactoryGirl.define do
  factory :user do
    sequence(:name){ |i| "Peter Lustig#{i}"}
    password "password"
    email {"#{name}@example.org".downcase.delete(' ')}
    street "Muster Strasse 15"
    city "Entenhausen"
    postal "12345"
    admin false
  end

  trait :invalid_attributes do
    name ''
    password ''
    email 'invalidmail.com'
    postal ''
    city ''
    street ''

  end

end
