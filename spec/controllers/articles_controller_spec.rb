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
end
