require 'rails_helper'

feature "order management" do 
  let!(:order2) {create(:order)} 
  def log_in_as(user)
    visit new_user_session_path
    expect(page).to have_content 'Anmeldung'
    within("#new_user") do
      fill_in 'E-Mail', :with => user.email
      fill_in 'Passwort', :with =>user.password
    end
    click_button 'Anmelden'
    visit orders_path
  end

  def set_order_status(order,status_id)
    order.order_status = status_id
    order.reload
    visit orders_path
  end

  context "admin" do
    before(:each) do
      log_in_as(create(:user, admin: true))
      @order = create(:order)
    end

    scenario "admin does not see any orders with status 'Erstellung'" do
      expect(page).not_to have_content 'Erstellung'
    end

    scenario "admin does see orders with status 'Auftrag'" do
      set_order_status(order2, 1)
      expect(page).to have_content 'Auftrag'
    end

    scenario "admin does see orders with status 'Abgeschickt'" do
      set_order_status(@order, 2)
      expect(page).to have_content 'Abgeschickt'
    end

    scenario "admin does see orders with status 'Angekommen'" do
      set_order_status(@order, 3)
      expect(page).to have_content 'Angekommen'
    end

    scenario "admin does see orders with status 'Storniert'" do
      set_order_status(@order, 4)
      expect(page).to have_content 'Storniert'
    end

    scenario "admin sees delete button"

    scenario "after clicking delete button, order is gone"

    scenario "admin sees detail button"

    scenario "after clicking delete button, show renders"

    scenario "admin sees 'Liefern' button"

    scenario "after clicking 'Liefern' Status changed"


  end
end
