require 'rails_helper'

feature "the login process" do 
  let!(:admin){create(:user, admin: true)}
  let!(:user) {create(:user)}
  
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
      before(:each) do
        log_in_as(admin)
      end
      scenario "expect Admin to have a button to add an article" do
        click_on 'Stammdaten'
        expect(page).to have_link('', :href => new_article_path)
      end
  
  end

  context "Normal User Tests" do
      before(:each) do
        log_in_as(user)
      end
      scenario "sign in" do
        expect(page).to have_content 'Willkommen bei Foodle!'
      end
  
      scenario "expect delete-button to be in user-edit" do
        click_on 'Profil bearbeiten'
        expect(page).to have_button('Ja, Account löschen')
      end
      
      scenario "expect User not to have a button to add an article" do
        click_on 'Bestellen'
        expect(page).not_to have_link('', :href => new_article_path)
      end
  
  end

  context "Admin and User Tests" do
      before(:each) do
        log_in_as(admin)
      end
      scenario "expect Admin to have edit-button in Alle Nutzer" do
        click_on 'Benutzer'
        expect(page).to have_link('', :href => edit_user_path(user))
      end
  
      scenario "expect Admin to have delete-button in Alle Nutzer" do
        click_on 'Benutzer'
        expect(page).to have_link('', :href => user_path(user), :count => 2)
      end
  end

  context "User and User Tests" do
      before(:each) do
        log_in_as(user)
      end
      scenario "expect User not to have a Benutzer Button" do
        user2 = create(:user)
        expect(page).not_to have_link('', :href => users_path)
      end
     
  end

  scenario "expect Bestellen Button in Navbar links to correct path for normal users" do
    visit new_user_session_path
    click_on 'Bestellen'
    expect(current_path).to eq(bestellen_path)
  end


end
