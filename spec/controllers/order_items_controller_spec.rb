require 'rails_helper'
  
  RSpec.describe OrderItemsController, type: :controller do
  let!(:order){create(:order, user_id: user, order_items: [order_item])}
  let(:order_item) {create(:order_item, quantity: 3, article_id: article.id)}
  let(:article) {create(:article)}
  let(:user) {create(:user)}

  describe "POST  #create" do

  end

  describe "POST #update" do

	context "admin" do
	before(:each) do
          sign_in(create(:user, admin:true))
	  current_order = order
	end
          it "does not update the quantity of the article" do
	    put :update, :id => order_item.id,:article_id => order_item.article_id, :quantity => 2
	    order_item.reload
	    expect(order_item.quantity).to eq(3)
	  end
	end

	context "user" do
	before(:each) do
	  sign_in(user)
	end
          it "updates the quantity of the article" do
	    put :update, :id => order_item.id,:article_id => order_item.article_id, :quantity => 2
	    order_item.reload
	    expect(order_item.quantity).to eq(2)
	  end

	end

	context "no user" do
          it "does not update the quantity of the article" do 
	    put :update, :id => order_item.id,:article_id => order_item.article_id, :quantity => 2
	    order_item.reload
	    expect(order_item.quantity).to eq(3)
	  end
	end
  end

  describe "POST #destroy" do
          
	context "admin" do

	  # could not be found because in the controller we are using current_order
	  it "could not deletes an order item" do
            sign_in(create(:user, admin: true))
	    @order_item = create(:order_item)
	    current_order = create(:order, order_items: [@order_item])
	    current_order.reload
	    @order_item.reload
	    session[current_order.id] = current_order.id
	    expect{ delete :destroy, :id => @order_item.id}.to change(current_order, :count).by(-1)
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
