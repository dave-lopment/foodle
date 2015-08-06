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
    it "assigns a new Article to @article"
    it "renders the :new template"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new article in the database"
      it "redirects to the home page"
    end

    context "with invalid attributes" do
      it "does not save the new article in the database"
      it "re-renders the :new template"
    end
  end
end
