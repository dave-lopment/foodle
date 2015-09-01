require 'rails_helper'

feature "Admin logs in and sees the 'Stammdaten' page (article#index)" do
	let(:admin){FactoryGirl.create(:user, admin: true)}
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

	before(:each) do
		# loggin in as admin redirects to the Stammdaten page!
		log_in_as(admin)
		visit articles_path
	end

	scenario "he sees categories' buttons" do
		expect(page).to have_link("Alle", :href => articles_path)
		expect(page).to have_link("#{category.name}", articles_path(filter: "#{category.id}"))
	end

	scenario "he sees articles" do
		expect(page).to have_content "#{article.name}"
	end

	scenario "he sees edit buttons for articles" do
		expect(page).to have_link("", edit_article_path("#{article.id}"))
	end

	scenario "he can delete articles" do
		expect(page).to have_link('destroy')
		expect { click_link 'destroy' }.to change(Article, :count).by(-1)
	end

	scenario "he sees pagination for articles" do
		44.times {create(:article, category_id: category.id)}
		visit articles_path
		expect(page).to have_css('div.pagination')
	end


end
