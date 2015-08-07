require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      let (:alice) {Fabricate(:user)}
      it "puts the signed in user in the session" do
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end

      it "redirects to the home path" do 
        post :create, email: alice.email, password: alice.password
        expect(response).to redirect_to home_path
      end

      it "sets the notice" do
        post :create, email: alice.email, password: alice.password
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credentials" do
      let(:alice) {Fabricate(:user)}
      it "doesn't put the user in the session" do
        post :create, email: alice.email, password: "wrong_password"
        expect(session[:user_id]).to eq(nil)
      end

      it "redirects to the sign in page" do
        post :create, email: alice.email, password: "wrong_password"
        expect(response).to redirect_to login_path
      end

      it "sets the error message" do
        post :create, email: alice.email, password: "wrong_password"
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    it "clears the session for the user" do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(response).to redirect_to root_path
    end
    it "sets the notice" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(flash[:notice]).not_to be_blank
    end
  end

end