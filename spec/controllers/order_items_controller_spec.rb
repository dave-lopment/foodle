require 'rails_helper'
  
  RSpec.describe OrderItemsController, type: :controller do
 
  describe "POST  #create" do

	  it "add some examples"
  end

  describe "POST #update" do

	it "add some examples"

  end

  describe "POST #destroy" do
          
	context "admin" do

	  it "deletes an order item" do
            sign_in(create(:user, admin: true))
	    order_item = create(:order_item)
	    expect{ delete :destroy, :id => order_item}.to change(OrderItem, :count).by(-1)
	  end

	end

	  it "add some examples"

  end

  end
