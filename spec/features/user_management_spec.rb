require 'rails_helper'

feature "the login process" do 
 
  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with =>user.password
    end
    click_button 'Anmelden'
  end

  scenario "sign in with wrong credentials" do
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => 'user@example.de'
      fill_in 'Passwort', :with => '12345678'
    end
    click_button 'Anmelden'
    expect(page).to have_content 'Invalid email or password'
  end
  
  context "Admin Tests" do
    let(:admin){FactoryGirl.create(:user, {email: "peter@lustig.de", password: "12345678", password_confirmation: "12345678", admin: true})}
    subject{admin}
  
      scenario "expect Admin to have a button to add an article" do
        log_in_as(admin)
        click_on 'Stammdaten'
        expect(page).to have_link('', :href => new_article_path)
      end
  
      scenario "expect Admin to have a button to edit an article"
  
      scenario "expect Admin to have a button to delete an article"
  end

  context "Normal User Tests" do
    let(:user) { FactoryGirl.create(:user, {email: "user@example.de", password: "password", password_confirmation: "password"})}
    subject {user}

      scenario "sign in" do
        log_in_as(user)
        expect(page).to have_content 'Willkommen bei Foodle!'
      end
  
      scenario "expect delete-button to be in user-edit" do
        log_in_as(user)
        click_on 'Profil bearbeiten'
        expect(page).to have_button('Ja, Account löschen')
      end
      
      # Should not be appear for normal user 
      # scenario "expect Alle-Nutzer to link to the right path" do
      #  log_in_as(user)
      #  click_on 'Alle Nutzer'
      #  expect(current_path).to eq(users_path)
      # end

      scenario "expect User not to have a button to add an article" do
        log_in_as(user)
        click_on 'Bestellen'
        expect(page).not_to have_link('', :href => new_article_path)
      end
  
      scenario "expect User not to have a button to edit an article"
  
      scenario "expect User not to have a button to delete an article"
        
      scenario "expect to have an quantity input"
  
      scenario "expect to have a add to cart button (submit)"
  end

  context "Admin and User Tests" do
    let(:admin) { FactoryGirl.create(:user, {email: "user@example.de", password: '12345678', password_confirmation: '12345678', admin: true    })}
    subject{admin}

      scenario "expect Admin to have edit-button in Alle Nutzer" do
        # find a way to get the user creation out of each scenario
        user = FactoryGirl.create(:user)
        log_in_as(admin)
        click_on 'Benutzer'
        expect(page).to have_link('', :href => edit_user_path(user))
      end
  
      scenario "expect Admin to have delete-button in Alle Nutzer" do
      user = FactoryGirl.create(:user)
        log_in_as(admin)
        click_on 'Benutzer'
        expect(page).to have_link('', :href => user_path(user), :count => 2)
      end
  end

  context "User and User Tests" do
    let (:user){FactoryGirl.create(:user, {email: "user@example.de", password: '12345678' , password_confirmation: '12345678'   })}
    subject{user}

      scenario "expect User not to have a Benutzer Button" do
        # find a way to get the user creation out of each scenario
        user2 = FactoryGirl.create(:user)
        log_in_as(user)
        expect(page).not_to have_link('', :href => users_path)
      end
     
  end

  scenario "expect Bestellen Button in Navbar links to correct path for normal users" do
    visit new_user_session_path
    click_on 'Bestellen'
    expect(current_path).to eq(bestellen_path)
  end


end
