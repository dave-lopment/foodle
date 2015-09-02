require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    context "admin" do	  
      let(:admin){create(:user,admin: true)}
      before(:each) do
        sign_in(admin)
      end
      it "assigns @categories for admins" do 
        category = create(:category) 
        get :index 
        expect(assigns(:categories)). to eq([category])
      end 
    
      it "assings @articles for admins" do
        article = create(:article)
        get :index
        expect(assigns(:articles)).to eq([article])
      end
    
      it "renders the :index view for admins" do
        get :index
        expect(response).to render_template(:index)
      end
    end
    context "normal user" do
      let(:user){create(:user)}
      before(:each) do
        sign_in(user)
      end
      it "redirects to the bestellungen view for normal users" do 
        get :index 
        expect(response).to redirect_to(bestellen_path)
      end 
    end
    context "everyone else" do
      it "redirects to the bestellungen view for everyone else" do 
        get :index 
        expect(response).to redirect_to(bestellen_path)
      end 
    end
  end

  describe "GET #bestellen" do 

    it "assigns @categories" do 
      category = create(:category) 
      get :bestellen 
      expect(assigns(:categories)). to eq([category])
    end 

    it "assigns @articles" do
      article = create(:article)
      get :bestellen 
      expect(assigns(:articles)).to eq([article])
    end
    
    it "redirects to the index view for admins" do 
      sign_in(create(:user, admin: true))
      get :bestellen 
      expect(response).to redirect_to(articles_path)
    end 

    it "renders the bestellen view for normal users" do 
      sign_in(create(:user))
      get :bestellen 
      expect(response).to render_template(:bestellen)
    end 

    it "renders the bestellen view for everyone else" do 
      get :bestellen 
      expect(response).to render_template(:bestellen)
    end
  end 

  describe "GET #show" do
    context "admin" do
      let(:article){create(:article)}
      before(:each) do
        sign_in(create(:user, admin: true))
      end
      it "assigns the requested article to @article" do
        get :show, id: article
        expect(assigns(:article)).to eq(article)
      end

      it "renders the :show template" do
        get :show, id: article
        expect(response).to render_template(:show)
      end
    end 
  end

  describe "GET #new" do
    context "admin" do 
      before(:each) do
        sign_in(create(:user, admin: true))
      end
      it "assigns a new Article to @article" do
        get :new
        expect(assigns(:article)).to be_a(Article)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end 
  end

  describe "POST #create" do

    context "as admin with valid params" do
      before(:each) do 
        sign_in(create(:user, admin: true))
      end 

      it "creates a new Article" do
        expect{
          post :create, { article: attributes_for(:article)}
        }.to change(Article, :count).by(1)
      end
    end

    context "as admin with invalid attributes" do
      before(:each) do 
        sign_in(create(:user, admin: true))
      end 

      it "does not save the new article in the database" do
        expect{
          post :create, { article: attributes_for(:article, :fresh_article) }
        }.to_not change(Article, :count)
      end

      it "re-renders the :new template" do
        post :create, {article: attributes_for(:article, :fresh_article) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    let(:article){create(:article)}
    before(:each) do
      sign_in(create(:user, admin:true))
    end

    it "renders the :edit template" do
      get :edit, id: article
      expect(response).to render_template(:edit)
    end

    it "assigns the requested article to @article" do
      get :edit, id: article
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "DELETE #destroy" do
    let!(:article){create(:article)}
    it "deletes an article" do
      sign_in(create(:user, admin:true))
      expect {
        delete :destroy, :id => article.id
      }.to change(Article, :count).by(-1)
    end
  end

  describe "PUT #update" do
    let(:attr) do
      { :name => 'New Name', :description => 'New Description yeah', :price => 90.20 }
    end

    before(:each) do
      sign_in(create(:user, admin:true))
      @article = create(:article)
      put :update, :id => @article.id, :article => attr
      @article.reload
    end

    it "renders the view of the article" do
      expect(response).to redirect_to(@article)
    end

    it "updates the name attribute of the article" do
      expect(@article.name).to eq attr[:name]
    end

    it "updates the description of the article" do
      expect(@article.description).to eq attr[:description]
    end

    it "updates the price of the article" do
      expect(@article.price).to eq attr[:price]

    end
  end

  describe "redirect normal User or no user" do
     
      it "redirects user trying to get edit articles" do
        get :edit, id: create(:article)
        expect(response).to redirect_to(articles_path)
      end

      it "redirects user trying to get create articles" do
        get :new
	expect(response).to redirect_to(articles_path)
      end
  end
end
