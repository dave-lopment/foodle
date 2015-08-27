require 'rails_helper'

feature "general layout" do


  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with =>user.password
    end
    click_button 'Anmelden'
  end

	context "navbar as admin" do 
		let(:admin){FactoryGirl.create(:user, admin: true)}

        before(:each) do 
            log_in_as(admin)
        end 

    	scenario "has a link to 'articles#index'" do 
        	expect(page).to have_link('', :href => articles_path)
        end 

    	scenario "has a link to users#index" do 
        	expect(page).to have_link('', :href => users_path)
        end 

    	scenario "has a link to orders#index" do 
        	expect(page).to have_link('', :href => orders_path)
        end 

    	scenario "redirects to articles#index when 'Stammdaten' is clicked" do 
    		click_on 'Stammdaten' 
    		expect(current_path).to eq(articles_path)
    	end 

    	scenario "redirects to users#index when 'Benutzer' is clicked" do 
    		click_on 'Benutzer' 
    		expect(current_path).to eq(users_path)
    	end 

    	scenario "redirects to orders#index when 'Bestellungen' is clicked" do 
    		click_on 'Bestellungen' 
    		expect(current_path).to eq(orders_path)
    	end 

    	scenario "has admin-flag in navbar" do
        	expect(page).to have_content '(Admin)'
      	end

        scenario "has correct 'Account' functions" do
            expect(page).to have_content 'Account'
            expect(page).to have_content 'Profil bearbeiten'
            expect(page).to have_content 'Passwort ändern'
            expect(page).to have_content 'Abmelden'
            expect(page).not_to have_content 'Anmelden'
            expect(page).not_to have_content 'Registrieren'
        end
  
        scenario "has no Account functions after log-out but 'Anmelden' and 'Registrieren'" do
            click_on 'Abmelden'
            expect(page).not_to have_content 'Account'
            expect(page).not_to have_content 'Profil bearbeiten'
            expect(page).not_to have_content 'Passwort ändern'
            expect(page).not_to have_content 'Abmelden'
            expect(page).to have_content 'Anmelden'
            expect(page).to have_content 'Registrieren'
        end
          
        scenario "redirects to users#edit when 'Profil bearbeiten' is clicked" do
            click_on 'Profil bearbeiten'
            expect(current_path).to eq(edit_user_path(admin))
        end

        scenario "redirects to devise/registrations#edit when 'Passwort ändern' is clicked" do
            click_on 'Passwort ändern'
            expect(current_path).to eq(edit_user_registration_path(admin))
        end
	end 

	context "navbar as normal user" do 
		let (:user){FactoryGirl.create(:user)}
		subject{user}

        before(:each) do 
            log_in_as(user)
        end 

		scenario "has a link to home page" do 
			expect(page).to have_link('', :href => root_path)
		end 

		scenario "has a link to articles#bestellen" do 
			expect(page).to have_link('', :href => bestellen_path)
		end 

		scenario "has a link to orders#user_oders" do 
			expect(page).to have_link('', :href => user_orders_path)
		end 

        scenario "does not have an Admin flag" do 
            expect(page).not_to have_content('(Admin)')
        end 

        scenario "has correct 'Account' functions" do
            expect(page).to have_content 'Account'
            expect(page).to have_content 'Profil bearbeiten'
            expect(page).to have_content 'Passwort ändern'
            expect(page).to have_content 'Abmelden'
            expect(page).not_to have_content 'Anmelden'
            expect(page).not_to have_content 'Registrieren'
        end
  
        scenario "has no Account functions after log-out but 'Anmelden' and 'Registrieren'" do
            click_on 'Abmelden'
            expect(page).not_to have_content 'Account'
            expect(page).not_to have_content 'Profil bearbeiten'
            expect(page).not_to have_content 'Passwort ändern'
            expect(page).not_to have_content 'Abmelden'
            expect(page).to have_content 'Anmelden'
            expect(page).to have_content 'Registrieren'
        end
          
        scenario "redirects to users#edit when 'Profil bearbeiten' is clicked" do
            click_on 'Profil bearbeiten'
            expect(current_path).to eq(edit_user_path(user))
        end

        scenario "redirects to devise/registrations#edit when 'Passwort ändern' is clicked" do
            click_on 'Passwort ändern'
            expect(current_path).to eq(edit_user_registration_path(user))
        end

	end 



end 