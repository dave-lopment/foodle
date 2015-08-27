require 'rails_helper'

feature "Admin logs in and sees the 'Stammdaten' page (article#index)" do

	def log_in_as(user)
	   	visit new_user_session_path
	   	expect(page).to have_content 'Anmeldung'
	    within("#new_user") do
	      	fill_in 'E-Mail', :with => user.email
	      	fill_in 'Passwort', :with =>user.password
	    end
	  	  click_button 'Anmelden'
  	end
	

	let(:admin){FactoryGirl.create(:user, admin: true)}

	before(:each) do 
		# loggin in as admin redirects to the Stammdaten page!
		log_in_as(admin)
	end 

	scenario "he sees categories' buttons"

	scenario "he sees articles"

	scenario "he sees edit buttons for articles"

	scenario "he sees delete buttons for articles"

	scenario "he sees pagination for articles"


end 