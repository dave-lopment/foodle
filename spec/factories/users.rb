# do -> gem install factory_girl
# add require 'factory_girl' to your test_helper.rb or spec_helper.rb

FactoryGirl.define do
  factory :user do
    sequence(:name){ |i| "Peter Lustig#{i}"}
  end
end
