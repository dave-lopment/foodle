require 'rails_helper'

describe Category do

  it "should be valid with normal attributes" do
    category = build(:category)
    expect(category).to be_valid
  end

  context "Name Attribute Tests" do
    it "should be invalid when name is nil" do
      category = build(:category, name: nil)
      expect(category).not_to be_valid
    end
 
    it "should be invalid when name is blank" do
      category = build(:category, name: '  ')
      expect(category).not_to be_valid
    end
 
    it "should be invalid if name too long" do
      category = build(:category, name: 'a'*33)
      expect(category).not_to be_valid
    end
  end

  context "destroy" do
    it "destroys its articles when itself gets destroyed" do
      @category = create(:category)
      @article1 = @category.articles.create( name: "i will be deleted 1",
                                    price: 9.99,
                                    description: "a description 1")
      @article2 = @category.articles.create( name: "i will be deleted 2",
                                    price: 9.99,
                                    description: "a description 2")
      expect{Category.destroy(@category)}.to change(Article, :count).from(2).to(0)
    end
  end

end
