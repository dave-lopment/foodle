require 'rails_helper'

describe Category do
  it "should be invalid when no name" do
    categorie = build(:category, name: '  ')
    expect(categorie).not_to be_valid
  end
end
