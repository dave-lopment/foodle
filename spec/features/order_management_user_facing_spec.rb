require 'rails_helper'

feature 'order management user facing' do

  #TODO Put log_in_as(user) and set_order_status to a test_helper file

  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with => user.password
    end
    click_button 'Anmelden'
    visit meine_bestellungen_path
  end

  def set_order_status(order, status_id)
    order.order_status = status_id
    order.reload
    visit meine_bestellungen_path
  end

  context "user" do
    before(:each) do
      log_in_as(create(:user))
      @order = create(:order)
    end

    context "show only orders with correct status" do
      scenario "user does not see any orders with status 'Erstellung'" do
        expect(page).not_to have_content 'Erstellung'
      end
 
      scenario "user does see orders with status 'Auftrag'" do
        set_order_status(order2, 1)
        expect(page).to have_content 'Auftrag'
      end
 
      scenario "user does see orders with status 'Abgeschickt'" do
        set_order_status(@order, 2)
        expect(page).to have_content 'Abgeschickt'
      end
 
      scenario "user does see orders with status 'Angekommen'" do
        set_order_status(@order, 3)
        expect(page).to have_content 'Angekommen'
      end
 
      scenario "user does see orders with status 'Storniert'" do
        set_order_status(@order, 4)
        expect(page).to have_content 'Storniert'
      end

    end

    context "Test if all links, buttons and functions are there" do
      before(:each) do
        set_order_status(@order,1)
      end

      scenario "user sees detail link" do
        expect(page).to have_link 'Details'
      end
 
      scenario "after clicking details button, show renders" do
        click_on 'Details'
        expect(page).to render(show_order_path)
      end
 
      scenario "user sees 'Stornieren' button" do 
        expect(page).to have_content 'Stornieren'
      end
 
      scenario "after clicking 'Stornieren' Status changed" do
        click_on 'Stornieren'
        expect(page).to have_content 'Storniert'
      end
    end

    context "User's order detail view" do

      before(:each) do
        set_order_status(@order,1)
	@order_item = @order.order_items.first
        click_on 'Details'
      end

      scenario "Detail View got a 'zurück'-Button" do
        expect(page).to have_button 'Zurück'
      end
 
      scenario "Detail View got a column for article quantity" do
        expect(page).to have_content @order_item.quantity
      end
 
      scenario "Detail View got a column for article name" do
	expect(page).to have_content @order_item.name
      end

      scenario "Detail View got a column for total price" do
        expect(page).to have_content @order_item.total_price
      end

    end
  end
end
