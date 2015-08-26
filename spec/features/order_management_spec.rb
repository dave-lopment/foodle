require 'rails_helper'

feature "order management" do 
 
  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with =>user.password
    end
    click_button 'Anmelden'
  end

  scenario "admin does not see any orders with status 'Erstellung'"

end
