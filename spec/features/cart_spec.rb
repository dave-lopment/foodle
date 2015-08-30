require 'rails_helper'

#TODO Put log_in_as(user) and set_order_status to a test_helper file

feature "cart action" do

  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
       fill_in 'E-Mail', :with => user.email
       fill_in 'Passwort', :with =>user.password
     end
    click_button 'Anmelden'
  end

it "Expect to add article to cart after clicking the add button"

it "Expect to have one article of quantity 2 after clicking add button twice"

it "Expect to have one article with quantity x after clicking add button with qua    ntity x" 

it "Expect not to increase number of article in cart when adding article with qua    ntity 0"

it "Expect to equal the new quantity after updating quantity"

it "Expect not to update quantity when updating quantity to 0"

it "Expect to decrease cart count after delete article"

end
