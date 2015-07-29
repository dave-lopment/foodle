require 'rails_helper'

describe Article do
  it "expect normal article to be valid" do
    article = build(:article)
    expect(article).to be_valid
  end

  it "ecpect not to be valid when name is nil" do
    article = build(:article, name: nil)
    expect(article).not_to be_valid
  end

  it "expect not to be valid when name is blank" do
    article = build(:article, name: '    ')
    expect(article).not_to be_valid
  end

  it "expect not to be valid when no price" do
    article = build(:article, price: nil)
    expect(article).not_to be_valid
  end

  it "expect not to be valid when price less than 0" do
    article = build(:article, price: -50)
    expect(article).not_to be_valid
  end

  it "expect price to have correct format (number.xx)" do
    article = build(:article, price: 10.123)
    expect(article).not_to be_valid
  end

  it "expet to be invalid when description is nil" do
    article = build(:article, description: nil)
    expect(article).not_to be_valid
  end

  it "expect to be invalid when description is blank" do
    article = build(:article, description: '   ')
    expect(article).not_to be_valid
  end

end
