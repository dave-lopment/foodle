require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user){create(:user)}
  let!(:admin){create(:user, admin:true)}
  describe "GET #index" do

    before(:each) do
      sign_in(admin)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before(:each) do
      sign_in(admin)
    end
    it "assigns the requested user to @user" do
      get :show, id: user
      expect(assigns(:user)).to eq(user)
    end

    it "renders the :show template" do
      get :show, id: user
      expect(response).to render_template(:show)
    end
  end

  describe "DELETE #destroy" do
  before(:each) do
    sign_in(admin)
  end
    it "deletes an user" do
      expect {
        delete :destroy, id: user.id
      }.to change(User, :count).by(-1)
    end
  end

  describe "GET #edit" do

    before(:each) do
      sign_in(admin)
    end

    it "renders the :edit template" do
      get :edit, id: user
      expect(response).to render_template(:edit)
    end

    it "assigns the requested user to @user" do
      get :edit, id: user
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "Normal User or no user redirect" do
  
    context "User" do
      
      before(:each) do 
        sign_in(user)
      end

      it "user redirect trying to get all users" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      it "user redirect trying to edit user" do
	get :edit, id: create(:user)
	expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "No user" do

      it "no user redirect trying to get all users" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      it "no user redirect trying to edit user" do
	get :edit, id: create(:user)
	expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
