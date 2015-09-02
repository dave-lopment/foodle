require 'rails_helper'

feature "order management admin facing" do 
  let(:order) {create(:order, order_items: [order_item])}
  let(:order_item){create(:order_item)}

  context "admin" do
    before(:each) do
      log_in_as(create(:user, admin: true))
    end

    context "show only orders with correct status" do

      scenario "admin does not see any orders with status 'Erstellung'" do
        expect(page).not_to have_content 'Erstellung'
      end
 
      scenario "admin does see orders with status 'Auftrag'" do
        set_order_status(order, 1)
        expect(page).to have_content 'Auftrag'
      end
 
      scenario "admin does see orders with status 'Abgeschickt'" do
        set_order_status(order,2)
        expect(page).to have_content 'Abgeschickt'
      end
 
      scenario "admin does see orders with status 'Angekommen'" do
        set_order_status(order,3)
        expect(page).to have_content 'Angekommen'
      end
 
      scenario "admin does see orders with status 'Storniert'" do
        set_order_status(order,4)
        expect(page).to have_content 'Storniert'
      end

    end
    context "Test if all links, buttons and functions are there" do
      before(:each) do
        set_order_status(order,1)
      end

      scenario "admin sees detail link" do
        expect(page).to have_link 'Details'
      end
 
      scenario "after clicking details button, show renders" do
        click_link 'Details'
        expect(current_path).to eq(order_path(order.id))
      end
 
 
      scenario "admin sees 'Liefern' button" do 
        expect(page).to have_content 'Liefern'
      end
 
      scenario "after clicking 'Liefern' Status changed" do
        click_link 'Liefern'
        expect(page).to have_content 'Abgeschickt'
      end
    end

    context "Admin's order detail view" do

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
