# do -> gem install factory_girl
# add require 'factory_girl' to your test_helper.rb or spec_helper.rb

FactoryGirl.define do
  factory :user do
    sequence(:name){ |i| "Peter Lustig#{i}"}
    email_address {"#{name}@example.org".downcase.delete(' ')}
    street "Muster Strasse 15"
    city "Entenhausen"
    postal "12345"
  end
end
