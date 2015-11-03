require 'spec_helper'

describe VideosController do

  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id #to log us in for running the test
      end

      it "sets @reviews" do
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review1, review2])

      end

      it "sets the @video variable" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

    end

    context "with unauthenticated users" do
      it "redirects the user to the sign in page" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET search" do

    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: "Futurama")
      get :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])
    end

    it "redirects to sign in page for the unauthenticated users" do
      futurama = Fabricate(:video, title: "Futurama")
      get :search, search_term: 'rama'
      expect(response).to redirect_to login_path
    end
  end
end