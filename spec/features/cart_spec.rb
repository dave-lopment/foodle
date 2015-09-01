require 'rails_helper'

#TODO Put log_in_as(user) and set_order_status to a test_helper file

feature "cart action" do
  let(:category){create(:category)}
  let!(:article){create(:article, category_id: category.id)}

  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
       fill_in 'E-Mail', :with => user.email
       fill_in 'Passwort', :with =>user.password
     end
    click_button 'Anmelden'
  end

  def put_sth_to_cart(product)
    visit bestellen_path
    click_button("#{product.name}-cart-button")
  end

  def increase_quantity(product, quantity)
    find_field("#{product.name}-quantity").value.set(quantity)
  end

  context "admin" do

  end

  context "user" do
    let(:user){create(:user)}
    let(:article2){create(:article, category_id: category.id)}

    before(:each) do
      log_in_as(user)
      visit bestellen_path
    end

    it "adds article to cart after clicking the add button" do
      put_sth_to_cart(article)
      expect(page).to have_content '1 in Warenkorb'
    end

    it "after adding same article twice, has two articles in the cart" do
      put_sth_to_cart(article)
      put_sth_to_cart(article)
      expect(page).to have_content '2 in Warenkorb'
    end

    it "after adding two articles, there are two articles in the cart" do
      put_sth_to_cart(article)
      put_sth_to_cart(article2)
      expect(page).to have_content '2 in Warenkorb'
    end

    it "after adding article with quantity 2, there are two articles in cart" do
      increase_quantity(article, 2)
      put_sth_to_cart(article)
      expect(page).to have_Content '2 in Warenkorb'
    end

  end


it "Expect to have one article of quantity 2 after clicking add button twice"

it "Expect to have one article with quantity x after clicking add button with qua    ntity x" 

it "Expect not to increase number of article in cart when adding article with qua    ntity 0"
  describe 'inside cart' do
   let(:user){create(:user)}
   let(:article2){create(:article)}

   context "user" do
     let(:user){create(:user)}
     let!(:article2){create(:article, category_id: category.id)}

     before(:each) do
       log_in_as(user)
       visit bestellen_path
     end

     it "has one article with quantity one in cart" do
       put_sth_to_cart(article)
       visit cart_path
       expect(page).to have_content article.name
       expect(page).to have_content (1)
     end
 
     it "has one article with quantity two in cart" do
       put_sth_to_cart(article)
       put_sth_to_cart(article)
       visit cart_path
       expect(page).to have_content article.name
       expect(page).to have_selector ("input[value='2']")
     end
 
     it "has one article with quantity 7 in cart" do
       increase_quantity(article, '7')
       save_and_open_page
       put_sth_to_cart(article)
       visit cart_path
       save_and_open_page
       expect(page).to have_selector ("input[value='7']")
     end
 
     it "has two articles with quantity one in cart" do
       put_sth_to_cart(article)
       put_sth_to_cart(article2)
       visit cart_path
       expect(page).to have_content article.name
       expect(page).to have_content article2.name
     end


    it "Expect to equal the new quantity after updating quantity" 
  end

 end


it "Expect not to update quantity when updating quantity to 0"

it "Expect to decrease cart count after delete article"

end
