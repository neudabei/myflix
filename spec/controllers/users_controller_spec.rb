require 'spec_helper'

describe UsersController do
  
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid personal info and valid card" do
      let(:charge) { double(:charge, successful?: true) }
      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

      it "creates the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: {email: "joe@example.com", password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token 
        expect(User.count).to eq(2)
      end

      it "redirects to the sign in page" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: {email: "joe@example.com", password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token 
        expect(response).to redirect_to login_path
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: {email: "joe@example.com", password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token
        joe = User.find_by(email: "joe@example.com")
        expect(joe.follows?(alice)).to be true
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: {email: "joe@example.com", password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token
        joe = User.find_by(email: "joe@example.com")
        expect(alice.follows?(joe)).to be true
      end

      it "expires the invitation upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        post :create, user: {email: "joe@example.com", password: "password", full_name: "Joe Doe"}, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end
    end

    context "valid personal info and declined card" do
      it "does not create a new user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: "11242142"
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: "11242142"
        expect(response).to render_template :new
      end

      it "sets the flash error message" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: "11242142"
        expect(flash[:error]).to be_present
      end
    end

    context "invalid personal info and valid card" do
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

      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
      end

      it "does not send out the email when inputs are invalid" do
        ActionMailer::Base.deliveries.should be_empty
      end
    end

    context "email sending" do

      let(:charge) {double(:charge, successful?: true)}
      before do
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end

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

  describe "GET new_with_invitation_token" do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: "asdafsf"
      expect(response).to redirect_to expired_token_path
    end
  end
end