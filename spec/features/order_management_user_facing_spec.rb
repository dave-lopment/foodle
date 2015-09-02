require 'rails_helper'

feature 'order management user facing' do
  let(:user) {create(:user)}
  let(:order) {create(:order, :order_items => [order_item], :user_id => user.id)}
  let(:order_item){create(:order_item)}

  context "user" do
    before(:each) do
      log_in_as(user)
    end

    context "show only orders with correct status" do
      scenario "user does not see any orders with status 'Erstellung'" do
        expect(page).not_to have_content 'Erstellung'
      end
 
      scenario "user does see orders with status 'Auftrag'" do
        set_order_status(order, 1)
        expect(page).to have_content 'Auftrag'
      end
 
      scenario "user does see orders with status 'Abgeschickt'" do
        set_order_status(order, 2)
        expect(page).to have_content 'Abgeschickt'
      end
 
      scenario "user does see orders with status 'Angekommen'" do
        set_order_status(order, 3)
        expect(page).to have_content 'Angekommen'
      end
 
      scenario "user does see orders with status 'Storniert'" do
        set_order_status(order, 4)
        expect(page).to have_content 'Storniert'
      end

    end

    context "Test if all links, buttons and functions are there" do
      before(:each) do
        set_order_status(order,1)
      end

      scenario "user sees detail link" do
        expect(page).to have_link 'Details'
      end
 
      scenario "after clicking details button, show renders" do
        click_link 'Details'
        expect(current_path).to eq(order_path(order.id))
      end
 
      scenario "user sees 'Stornieren' button" do 
        expect(page).to have_content 'Stornieren'
      end
 
      scenario "after clicking 'Stornieren' Status changed (Nicht möglich ohne JS("do
        click_link 'Stornieren'
        expect(page).to have_content 'Storniert'
      end
    end

    context "User's order detail view" do

      before(:each) do
        set_order_status(order,1)
	@order_item = order.order_items.first
        click_on 'Details'
      end

      scenario "Detail View got a 'zurück'-Button" do
        expect(page).to have_link 'Zurück'
      end
 
      scenario "Detail View got a column for article quantity" do
        expect(page).to have_content @order_item.quantity
      end
 
      scenario "Detail View got a column for article name" do
	expect(page).to have_content @order_item.article.name
      end

      scenario "Detail View got a column for total price" do
        expect(page).to have_content @order_item.total_price
      end

    end
  end
end
