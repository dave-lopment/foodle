require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    it "assings @articles" do
      article = create(:article)
      get :index
      expect(assigns(:articles)).to eq([article])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested article to @article" do
      article = create(:article)
      get :show, id: article
      expect(assigns(:article)).to eq(article)
    end

    it "renders the :show template" do
      article = create(:article)
      get :show, id: article
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new Article to @article" do
      get :new
      expect(assigns(:article)).to be_a(Article)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    context "with valid params" do
      it "creates a new Article" do
        expect{
          post :create, { article: attributes_for(:article)}
        }.to change(Article, :count).by(1)
      end
    end

    context "with invalid attributes" do
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
    it "renders the :edit template" do
      get :edit, id: create(:article)
      expect(response).to render_template(:edit)
    end

    it "assigns the requested article to @article" do
      article = create(:article)
      get :edit, id: article
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "DELETE #destroy" do
    it "deletes an article" do
      article = create(:article)
      expect {
        delete :destroy, :id => article.id
      }.to change(Article, :count).by(-1)
    end
  end

  # describe "PUT #update" do
  #   @article = create(:article)
  #   let(:attr) do
  #     { :name => 'New Name', :description => 'New Description yeah', :price => 99.99 }
  #   end
  #
  #   before(:each) do
  #     put :update, :id => @article.id, :article => attr
  #     @article.reload
  #   end
  #   it { expect(response).to redirect_to(@article) }
  #   it { expect(@article.name).to eq attr[:name] }
  #   it { expect(@article.description).to eq attr[:description]}
  #
  #
  # end

  describe "PUT #update" do
    let(:attr) do
      { :name => 'New Name', :description => 'New Description yeah', :price => 90.20 }
    end

    before(:each) do
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

end
