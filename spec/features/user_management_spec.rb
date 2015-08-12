require 'rails_helper'

feature "the login process" do 
  
  scenario "signs me in" do
    page.visit root_url
    expect(page).to have_content "Willkommen bei Foodle!"
  end
end
      
