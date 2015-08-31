require 'rails_helper'
  
  RSpec.describe OrderItemsController, type: :controller do
 
  describe "POST  #create" do

  end

  describe "POST #update" do
	let(:article){create(:article)
	let(:order_item){create(:order_item, {quantity: 3, article_id: [article]})}
	let(:order){create(:order, order_items: [order_item])}
	}
	context "admin" do
          it "does not update the quantity of the article"
	end

	context "user" do
	before(:each) do
          sign_in(create(:user))
	end
          it "updates the quantity of the article" do
	    put :update, :article_id => article.id, :quantity => 2
	    order_item.reload
	    expect(order_item.quantity).to eq(2)
	  end

	end

	context "no user" do

          it "does update the quantity of the article" 

	end

  end

  describe "POST #destroy" do
          
	context "admin" do

	  # could not be found because in the controller we are using current_order
	  it "could not deletes an order item" do
            sign_in(create(:user, admin: true))
	    order_item = create(:order_item)
	    current_order = create(:order, order_items: [order_item])
	    current_order.reload
	    order_item.reload
	    expect{ delete :destroy, :id => order_item}.to change(current_order, :count).by(-1)
	  end

	end

	context "user" do

          it "deletes an order item" 

	end

        context "no user" do
        
          it "deletes an order item" 

	end

  end

  end
