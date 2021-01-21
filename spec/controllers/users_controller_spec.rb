require "rails_helper"

RSpec.describe UsersController, type: :controller do
  #DESCRIBING NEW

  describe "#new" do
    it "renders a template to create a new news_article" do
      get(:new)

      expect(response).to(render_template(:new))
    end
    it "creates an instance variable of a User class with" do
      get(:new)
      expect(assigns(:user)).to(be_a_new(User))
    end
  end

  #DESCRIBING CREATE
  describe "#create" do
    context "checking with valid parameters " do
      it "creates a news user" do
        count_before = User.count
        FactoryBot.create(:user)
        count_after = User.count
        expect(count_after).to(eq(count_before + 1))
      end
    end
    it "redirects to products page" do
      post(:create, FactoryBot.create(:user, email: "some@thing.com"))
      expect(response).to redirect_to(products_path)
    end
  end
end
