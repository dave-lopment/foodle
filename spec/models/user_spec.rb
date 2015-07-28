require 'rails_helper'

describe User do
  it 'expect not to be valid' do
    user = build(:user, name: '')
    expect(user).not_to be_valid
  end
  it 'expect postal code not to be nil' do
    user = build(:user, :invalid_attributes)
    expect(user).not_to be_valid
  end
  it 'expect postal code not to be blank' do
    user = build(:user, postal: '   ')
    expect(user).not_to be_valid
  end
  it 'expect postal code length not to be less than 5' do
    user = build(:user, postal: "1234")
    expect(user).not_to be_valid
  end
  it 'expect postal code length not to be greater than 5' do
    user = build(:user, postal: "234235")
    expect(user).not_to be_valid
  end
  it 'expect postal code length to be 5' do
    user = build(:user)
    expect(user).to be_valid
  end
  it 'expect email to not have incorrect form' do
    user = build(:user, :invalid_attributes)
    expect(user).not_to be_valid
  end
  it 'expect email to have right form' do
    user = build(:user, email: 'valid@email.com');
    expect(user).to be_valid
  end
  it 'expect email not to be nil' do
    user = build(:user, email: '')
    expect(user).not_to be_valid
  end
  it 'expect email not to be blank' do
    user = build(:user, email: '   ')
    expect(user).not_to be_valid
  end
  it 'expect email_address to be unique' do
    userA = create(:user, email: 'abc@example.org') # user must be saved in the db
    userB = build(:user, email: 'abc@example.org') # new user with same email_address
    expect(userB).not_to be_valid
  end
  it 'expect street not to be nil' do
     user = build(:user, street: '')
     expect(user).not_to be_valid
  end
  it 'expect street not to be blank' do
     user = build(:user, street: '   ')
     expect(user).not_to be_valid
  end
  it 'expect street to be valid' do
    user = build(:user)
    expect(user).to be_valid
  end
  it 'expect city not to be nil' do
     user = build(:user, city: '')
     expect(user).not_to be_valid
  end
  it 'expect city not to be blank' do
     user = build(:user, city: '   ')
     expect(user).not_to be_valid
  end
  it 'expect city to be valid' do
     user = build(:user)
     expect(user).to be_valid
  end
  it 'expect user not to be admin by default' do
    user = build(:user)
    expect(user).not_to be_admin
  end
  it 'expect user to be admin' do
    user = build(:user, admin: true)
    expect(user).to be_admin
  end
end
