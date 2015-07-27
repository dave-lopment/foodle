require 'rails_helper'

describe User do
  it {should_not be_valid}

  it "name should not be blank" do
    subject.email_address = "abc@abc.de"
    subject.name = "    "
    expect(subject).not_to be_valid
  end


end
