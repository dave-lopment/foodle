require 'rails_helper'

feature "the login process" do 

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

  scenario "sign in" do
    user = FactoryGirl.create(:user, {email: "peter@lustig.de"})
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => "peter@lustig.de"
      fill_in 'Passwort', :with => 'password'
    end
    click_button 'Anmelden'
    expect(page).to have_content 'Willkommen bei Foodle!'
  end

  scenario "admin user got admin-flag in navbar" do
    adminUser = FactoryGirl.create(:user, {email: "peter@lustig.de", password: "12345678", admin: true})
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => adminUser.email
      fill_in 'Passwort', :with => adminUser.password
    end
    click_button 'Anmelden'
    expect(page).to have_content '(Admin)'
  end

  scenario "normal user got no admin-flag in navbar" do
    user = FactoryGirl.create(:user, {email: "user@example.de", password: "password"})
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with =>user.password
    end
    click_button 'Anmelden'
    expect(page).not_to have_content '(Admin)'
  end

  scenario "Logged in user got account functions" do
    user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    expect(page).to have_content 'Account'
    expect(page).to have_content 'Profil bearbeiten'
    expect(page).to have_content 'Passwort ändern'
    expect(page).to have_content 'Abmelden'
    expect(page).not_to have_content 'Anmelden'
    expect(page).not_to have_content 'Registrieren'
  end

  scenario "After log out user functions should be dissappeared" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Abmelden'
    expect(page).to have_content 'Anmelden'
    expect(page).to have_content 'Registrieren'
  end
  
  # Refactor SignIn with Warden Gem
  scenario "expect edit-user link direct to the right url" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Profil bearbeiten'
    expect(current_path).to eq(edit_user_path(user))
  end

  scenario "expect edit-password link direct to the right url" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Passwort ändern'
    expect(current_path).to eq(edit_user_registration_path(user))
  end

  scenario "expect delete-button to be in user-edit" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Profil bearbeiten'
    expect(page).to have_button('Ja, Account löschen')
  end

  scenario "expect Alle-Nutzer to link to the right path" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Alle Nutzer'
    expect(current_path).to eq(users_path)
  end

  scenario "expect Admin to have edit-button in Alle Nutzer" do
  admin = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678', admin: true    })
  user = FactoryGirl.create(:user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => admin.email
      fill_in 'Passwort', :with => admin.password
    end
    click_button 'Anmelden'
    click_on 'Alle Nutzer'
    expect(page).to have_link('', :href => edit_user_path(user))
  end

  scenario "expect Admin to have delete-button in Alle Nutzer" do
  admin = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678', admin: true    })
  user = FactoryGirl.create(:user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => admin.email
      fill_in 'Passwort', :with => admin.password
    end
    click_button 'Anmelden'
    click_on 'Alle Nutzer'
    expect(page).to have_link('', :href => user_path(user), :count => 2)
  end

  scenario "expect User not to have edit-button in Alle Nutzer" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
  user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Alle Nutzer'
    expect(page).not_to have_link('', :href => edit_user_path(user2))
  end

  scenario "expect User not to have delete-button in Aller Nutzer" do
  user = FactoryGirl.create(:user, {email: "user@example.de", password: '12345678'    })
  user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    click_on 'Alle Nutzer'
    expect(page).not_to have_link('', :href => user_path(user2), :count => 2)
  end

  scenario "expect Bestellen Button in Navbar links to correct path"

  scenario "expect Admin to have a button to add an article"

  scenario "expect Admin to have a button to edit an article"

  scenario "expect Admin to have a button to delete an article"

  scenario "expect User not to have a button to add an article"

  scenario "expect User not to have a button to edit an article"

  scenario "expect User not to have a button to delete an article"
    
  scenario "expect to have a add to cart button (submit)"

  scenario "expect Bestellen Button in Navbar links to correct path"

  scenario "expect Admin to have a button to add an article"

  scenario "expect Admin to have a button to edit an article"

  scenario "expect Admin to have a button to delete an article"

  scenario "expect User not to have a button to add an article"

  scenario "expect User not to have a button to edit an article"

  scenario "expect User not to have a button to delete an article"
    
  scenario "expect to have an quantity input"


end
