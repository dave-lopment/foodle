require 'rails_helper'
  
  RSpec.describe OrderItemsController, type: :controller do
  let!(:order){create(:order, user_id: user, order_items: [order_item])}
  let(:order_item) {create(:order_item, quantity: 3, article_id: article.id)}
  let(:article) {create(:article)}
  let(:user) {create(:user)}
  let(:article2){create(:article)}
  let(:attr_new_article){ attributes_for(:order_item, {quantity:1, order_id: order.id, article_id: article2.id})}
  let(:attr_old_article){attributes_for(:order_item, {quantity:2, order_id: order.id, article_id: article.id})}
  describe "POST  #create" do

    context "admin" do
      before(:each) do
        sign_in(create(:user, admin:true))
	session[:order_id] = order.id
      end
      it "cannot create an order item" do
        expect{post :create, {order_item: attr_new_article}}.to change(order.order_items, :count).by(0)
      end

    end

    context "user" do

      before(:each) do
        sign_in(user)
	session[:order_id] = order.id
      end
      it "can create an order item" do
	expect{post :create, {order_item: attr_new_article}}.to change(order.order_items, :count).by(1)
      end

      it "count of single article should be increased by quantity if already in cart" do
	expect(order.order_items.find_by(article_id: article.id).quantity).to eq(3)
	post :create, {order_item: attr_old_article}
	expect(order.order_items.find_by(article_id: article.id).quantity).to eq(5)
      end
    end

    context "no user" do
      before(:each) do
	session[:order_id] = order.id
      end
      it "can create an order item" do
	expect{post :create, {order_item: attr_new_article}}.to change(order.order_items, :count).by(1)
      end

      it "count of single article should be increased by quantity if already in cart" do
	expect(order.order_items.find_by(article_id: article.id).quantity).to eq(3)
	post :create, {order_item: attr_old_article}
        expect(order.order_items.find_by(article_id: article.id).quantity).to eq(5)
      end
    end

  end

  describe "POST #update" do

	context "admin" do
	before(:each) do
          sign_in(create(:user, admin:true))
	  session[:order_id] = order.id
	end
          it "does not update the quantity of the article" do
	    put :update, :id => order_item.id, :order_item => {:quantity => 2, :article_id => order_item.article_id}
	    order_item.reload
	    expect(order_item.quantity).to eq(3)
	  end
	end

	context "user" do
	before(:each) do
	  sign_in(user)
          session[:order_id] = order.id
	end
          it "updates the quantity of the article" do
	    put :update, :id => order_item.id, :order_item => {:quantity => 2, :article_id => order_item.article_id}
	    order_item.reload
	    expect(order_item.quantity).to eq(2)
	  end

	end

	context "no user" do
          before(:each) do
            session[:order_id] = order.id
	  end

          it "does update the quantity of the article" do 
	    put :update, :id => order_item.id, :order_item => {:quantity => 2, :article_id => order_item.article_id}
	    order_item.reload
	    expect(order_item.quantity).to eq(2)
	  end
	end
  end

  describe "POST #destroy" do
          
	context "admin" do
	  before(:each) do
            sign_in(create(:user, admin: true))
	    session[:order_id] = order.id
	  end

	  it "could not delete an order item" do
	    expect{ delete :destroy, :id => order_item.id }.to change(order.order_items, :count).by(0)
	  end

	end

	context "user" do
          before(:each) do
            sign_in(user)
	    session[:order_id] = order.id
	  end
          it "deletes an order item" do
            expect{ delete :destroy, :id => order_item.id}.to change(order.order_items, :count).by(-1)
	  end

	end

        context "no user" do
          before(:each) do
            session[:order_id] = order.id
	  end
          it "deletes an order item" do
            expect{ delete :destroy, :id => order_item.id}.to change(order.order_items, :count).by(-1)
	  end

	end

  end

  end
