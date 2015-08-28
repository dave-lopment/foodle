require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe "GET #index" do

    context "admin user" do
	before(:each){sign_in(create(:user, admin:true))}

        it "assigns @orders" do
	  order = create(:order)
	  get :index
	  expect(assigns(:orders)).to eq([order])
	end

	it "renders the :index view" do
          get :index
          expect(response).to render_template(:index)
        end
    end

    context "user" do
      before(:each){sign_in(create(:user))}

      it "redirects user trying to get index orders" do
        get :index
	expect(response).to redirect_to(meine_bestellungen_path)
      end

    end

    context "No user" do

      it "redirects no user trying to get index orders" do
        get :index
        expect(response).to redirect_to(bestellen_path)
      end

    end

  end

  describe "DELETE #destroy" do

    context "Admin" do

      it "deletes an article" do
        order = create(:order)
	sign_in(create(:user, admin:true))
        expect {
	  delete :destroy, :id => order.id
	}.to change(Order, :count).by(-1)
      end

      it "user tries to delete article, muss/kann man das testen?"

    end

  end

  describe "GET #show" do
    
    context "Admin" do
      before(:each) do
        sign_in(create(:user, admin:true))
        @order = create(:order)
      end
      it "assigns the requested order to @order" do
        get :show, id: @order
        expect(assigns(:order)).to eq(@order)
      end

      it "renders the :show template" do
	get :show, id: @order
	expect(response).to render_template(:show)
      end

    end

    context "User" do
      before(:each) do
        @user1 = create(:user)
	order_attr = FactoryGirl.attributes_for(:order)
	@user1.orders.create(order_attr)
      end

      it "does not show order to wrong user" do
	user2 = create(:user)
	sign_in(user2)
	get :show, id: @user1.orders.first.id
	expect(response).to redirect_to(meine_bestellungen_path)
      end
	
      it "shows order to the user" do
	sign_in(@user1)
	get :show, id: @user1.orders.first.id
	expect(response).to render_template(:show)
      end
    end

    context "No User" do

      it "does not show order to wrong user" do
        @user1 = create(:user)
        @user1.orders.create(FactoryGirl.attributes_for(:order))
	get :show, id: @user1.orders.first.id
	expect(response).to redirect_to(bestellen_path)
      end

    end
  end

  describe "GET #deliver_order" do
    before(:each) do
      @user1 =create(:user)
      order_attr = FactoryGirl.attributes_for(:order)
      @user1.orders.create(order_attr)
      @order = @user1.orders.first
    end

    context "Admin" do
      before(:each) do
	sign_in(create(:user, admin:true))
      end
   
      it "changes order status to Abgeschickt" do
	get :deliver_order, order_id: @order[:id]
	expect(@order.reload.Abgeschickt?).to be true
      end

      it "redirects after change status" do
        get :deliver_order, order_id: @order[:id]
	expect(response).to redirect_to(orders_path)
      end
    end

    context "User" do
      before(:each) do
        sign_in(@user1)
      end

      it "does not change order status to Abgeschickt" do
        get :deliver_order, order_id: @order[:id]
	expect(@order.reload.Abgeschickt?).not_to be true
      end

      it "redirects without changing status" do
        get :deliver_order, order_id: @order[:id]
	expect(response).to redirect_to(meine_bestellungen_path)
      end

    end

    context "No User" do

      it "does not change order status to Abgeschickt" do
        get :deliver_order, order_id: @order[:id]
	expect(@order.reload.Abgeschickt?).not_to be true
      end

      it "redirects without changing status" do
        get :deliver_order, order_id: @order[:id]
	expect(response).to redirect_to(bestellen_path)
      end

    end

  end

  describe "GET #user_orders" do

    context "Admin" do
      it "renders the :index template" do
        sign_in(create(:user, admin:true))
	get :user_orders
	expect(response).to redirect_to(orders_path)
      end     
    end

    context "User" do
      it "renders the :user_index template" do
        sign_in(create(:user))
	get :user_orders
	expect(response).to render_template(:user_orders)
      end
    end

    context "No User" do
      it "renders the :articles template" do
	get :user_orders
	expect(response).to redirect_to(bestellen_path)
      end
    end

  end
end
