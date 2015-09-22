require 'spec_helper'

describe UsersController do
  
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        expect(response).to redirect_to login_path
      end
    end

    context "with invalid input" do
      before do
        post :create, user: {password: "password", full_name: "Full Name" }
      end
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "email sending" do
      after { ActionMailer::Base.deliveries.clear }
      it "sends out the email when inputs are valid" do
        post :create, user: {email: "email@domain.com", password: "password", full_name: "Full Name" }
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it "sends to the correct recipient when inputs are valid" do
        post :create, user: {email: "email@domain.com", password: "password", full_name: "Full Name" }
        message = ActionMailer::Base.deliveries.last
        message.to.should == ["email@domain.com"]
      end

      it "send the correct content when inputs are valid" do
        post :create, user: {email: "email@domain.com", password: "password", full_name: "Full Name" }
        message = ActionMailer::Base.deliveries.last
        message.body.should include("Full Name")
      end

      it "does not send out the email when inputs are invalid" do
        post :create, user: {password: "password", full_name: "Full Name" }
        ActionMailer::Base.deliveries.should be_empty
      end


    end

  end

  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end

    it "sets @user" do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

end