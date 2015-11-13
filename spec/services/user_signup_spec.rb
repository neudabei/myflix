require 'spec_helper'

describe UserSignup do
  describe "#sign_up" do
    context "valid personal info and valid card" do
      let(:charge) { double(:charge, successful?: true) }
      before { StripeWrapper::Charge.should_receive(:create).and_return(charge) }
      after { ActionMailer::Base.deliveries.clear }

      it "creates a user" do
        UserSignup.new(Fabricate.build(:user)).sign_up("some_stripe_token", nil)
        expect(User.count).to eq(1)
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        UserSignup.new(Fabricate.build(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")).sign_up("some_stripe_token", invitation.token)
        joe = User.find_by(email: "joe@example.com")
        expect(joe.follows?(alice)).to be_truthy
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        UserSignup.new(Fabricate.build(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")).sign_up("some_stripe_token", invitation.token)
        joe = User.find_by(email: "joe@example.com")
        expect(alice.follows?(joe)).to be_truthy
      end

      it "expires the invitation upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: "joe@example.com")
        UserSignup.new(Fabricate.build(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")).sign_up("some_stripe_token", invitation.token)
        expect(Invitation.first.token).to be_nil
      end

      it "sends out the email when inputs are valid" do
        UserSignup.new(Fabricate.build(:user, email: "joe@example.com")).sign_up("some_stripe_token", nil)
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it "sends to the correct recipient when inputs are valid" do
        UserSignup.new(Fabricate.build(:user, email: "email@domain.com", password: "password", full_name: "Joe Doe")).sign_up("some_stripe_token", nil)
        message = ActionMailer::Base.deliveries.last
        message.to.should == ["email@domain.com"]
      end

      it "send the correct content when inputs are valid" do
        UserSignup.new(Fabricate.build(:user, email: "email@domain.com", password: "password", full_name: "Full Name")).sign_up("some_stripe_token", nil)
        message = ActionMailer::Base.deliveries.last
        message.body.should include("Full Name")
      end
    end


    context "valid personal info and declined card" do
      it "does not create a new user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        UserSignup.new(Fabricate.build(:user)).sign_up('1231241', nil)
        expect(User.count).to eq(0)
      end
    end

    context "invalid personal info and valid card" do
      before { UserSignup.new(User.new(email: "joe@example.com")).sign_up('1231241', nil) }
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
      end

      it "does not send out the email when inputs are invalid" do
        ActionMailer::Base.deliveries.should be_empty
      end
    end
  end
end