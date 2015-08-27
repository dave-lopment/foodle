require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe "GET #index" do

    context "admin user" do

        it "assings @orders" do
	  sign_in(create(:user, admin:true))
	  order = create(:order)
	  get :index
	  expect(assigns(:orders)).to eq([order])
	end

	it "renders the :index view" do
          sign_in(create(:user, admin:true))
          get :index
          expect(response).to render_template(:index)
        end
    end

    context "normal user or no user" do
      it "redirects user trying to get index orders" do
        get :index
        expect(response).to redirect_to(articles_path)
      end

    end

  end

  describe "GET #show" do
    
    context "Admin" do

      it "assings the requested order to @order" do
        sign_in(create(:user, admin:true))
	order = create(:order)
        get :show, id: order
        expect(assigns(:order)).to eq(order)
      end

      it "renders the :show template" do
        sign_in(create(:user, admin:true))
        order = create(:order)
	get :show, id: order
	expect(response).to render_template(:show)
      end

    end

    context "User or No User" do

      it "does not show order to wrong user"
	
      it "shows order to the user"

      it "shows a special user index to the user"

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
    end

  end

  describe "GET #user_index" do

    context "Admin" do
      it "renders the :index template" do
        sign_in(create(:user, admin:true))
	get :user_orders
	expect(response).to render_template(:index)
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
	expect(reponse).to redirect_to(articles_path)
      end
    end

  end
end
