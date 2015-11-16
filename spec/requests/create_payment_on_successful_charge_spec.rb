require "spec_helper"

describe "Create payment on successful charge" do
  let(:event_data) do
       {
      "id"=> "evt_177k392nDnAL4MMhmIWwHYjH",
      "object"=> "event",
      "api_version"=> "2012-10-26",
      "created"=> 1447669047,
      "data"=> {
        "object"=> {
          "id"=> "ch_177k382nDnAL4MMhwl5XfiU3",
          "object"=> "charge",
          "amount"=> 999,
          "amount_refunded"=> 0,
          "application_fee"=> nil,
          "balance_transaction"=> "txn_177k392nDnAL4MMhIKqrIiMY",
          "captured"=> true,
          "created"=> 1447669046,
          "currency"=> "gbp",
          "customer"=> "cus_7MSzXWHHKm2dHL",
          "description"=> nil,
          "destination"=> nil,
          "dispute"=> nil,
          "failure_code"=> nil,
          "failure_message"=> nil,
          "fraud_details"=> {},
          "invoice"=> "in_177k382nDnAL4MMhtevvPCam",
          "livemode"=> false,
          "metadata"=> {},
          "paid"=> true,
          "receipt_email"=> nil,
          "receipt_number"=> nil,
          "refunded"=> false,
          "refunds"=> [],
          "shipping"=> nil,
          "source"=> {
            "id"=> "card_177k372nDnAL4MMhZEVtNR9p",
            "object"=> "card",
            "address_city"=> nil,
            "address_country"=> nil,
            "address_line1"=> nil,
            "address_line1_check"=> nil,
            "address_line2"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_zip_check"=> nil,
            "brand"=> "Visa",
            "country"=> "US",
            "customer"=> "cus_7MSzXWHHKm2dHL",
            "cvc_check"=> "pass",
            "dynamic_last4"=> nil,
            "exp_month"=> 11,
            "exp_year"=> 2018,
            "fingerprint"=> "Af7aX4eCVf67Ne5O",
            "funding"=> "credit",
            "last4"=> "4242",
            "metadata"=> {},
            "name"=> nil,
            "tokenization_method"=> nil,
            "type"=> "Visa"
          },
          "statement_descriptor"=> nil,
          "status"=> "paid",
          "card"=> {
            "id"=> "card_177k372nDnAL4MMhZEVtNR9p",
            "object"=> "card",
            "address_city"=> nil,
            "address_country"=> nil,
            "address_line1"=> nil,
            "address_line1_check"=> nil,
            "address_line2"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_zip_check"=> nil,
            "brand"=> "Visa",
            "country"=> "US",
            "customer"=> "cus_7MSzXWHHKm2dHL",
            "cvc_check"=> "pass",
            "dynamic_last4"=> nil,
            "exp_month"=> 11,
            "exp_year"=> 2018,
            "fingerprint"=> "Af7aX4eCVf67Ne5O",
            "funding"=> "credit",
            "last4"=> "4242",
            "metadata"=> {},
            "name"=> nil,
            "tokenization_method"=> nil,
            "type"=> "Visa"
          },
          "statement_description"=> nil,
          "fee"=> 44,
          "fee_details"=> [
            {
              "amount"=> 44,
              "amount_refunded"=> 0,
              "application"=> nil,
              "currency"=> "gbp",
              "description"=> "Stripe processing fees",
              "type"=> "stripe_fee"
            }
          ],
          "disputed"=> false
        }
      },
      "livemode"=> false,
      "pending_webhooks"=> 2,
      "request"=> "req_7MSzm6DJPWemOS",
      "type"=> "charge.succeeded",
      "user_id"=> "acct_103kT12nDnAL4MMh"
    }
  end

  it "creates a payment with the webhook from stripe for a successful charge", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_7MSzXWHHKm2dHL")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: "cus_7MSzXWHHKm2dHL")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: "cus_7MSzXWHHKm2dHL")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_177k382nDnAL4MMhwl5XfiU3")
  end
end