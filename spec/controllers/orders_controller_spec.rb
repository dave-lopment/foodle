require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe "GET #index" do

    context "admin user" do
        it "shows order-index to admin" do
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

  describe "redirect normal User or no User" do
    
    it "redirects user trying to get other users orders"

  end
end
