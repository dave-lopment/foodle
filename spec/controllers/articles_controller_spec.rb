require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    # it "populates an array of articles"
    it "renders the :index view"
  end

  describe "GET #show" do
    it "assigns the requested article to @article"
    it "renders the :show template"
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
