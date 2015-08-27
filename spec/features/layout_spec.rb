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
    	subject{admin}

    	scenario "has a link to 'articles#index'" do 
	        log_in_as(admin)
        	expect(page).to have_link('', :href => articles_path)
        end 

    	scenario "has a link to users#index" do 
	        log_in_as(admin)
        	expect(page).to have_link('', :href => users_path)
        end 

    	scenario "has a link to orders#index" do 
	        log_in_as(admin)
        	expect(page).to have_link('', :href => orders_path)
        end 

    	scenario "redirects to articles#index when 'Stammdaten' is clicked" do 
    		log_in_as(admin)
    		click_on 'Stammdaten' 
    		expect(current_path).to eq(articles_path)
    	end 

    	scenario "redirects to users#index when 'Benutzer' is clicked" do 
    		log_in_as(admin)
    		click_on 'Benutzer' 
    		expect(current_path).to eq(users_path)
    	end 

    	scenario "redirects to orders#index when 'Bestellungen' is clicked" do 
    		log_in_as(admin)
    		click_on 'Bestellungen' 
    		expect(current_path).to eq(orders_path)
    	end 

    	scenario "has admin-flag in navbar" do
        	log_in_as(admin)
        	expect(page).to have_content '(Admin)'
      	end
	end 

	context "navbar as normal user" do 
		let (:user){FactoryGirl.create(:user)}
		subject{user}

		scenario "has a link to home page" do 
			log_in_as(user) 
			expect(page).to have_link('', :href => root_path)
		end 

		scenario "has a link to articles#bestellen" do 
			log_in_as(user) 
			expect(page).to have_link('', :href => bestellen_path)
		end 

		scenario "has a link to orders#user_oders" do 
			log_in_as(user) 
			expect(page).to have_link('', :href => user_orders_path)
		end 

        scenario "does not have an Admin flag" do 
            log_in_as(user)
            expect(page).not_to have_content('(Admin)')
        end 

	end 



end 