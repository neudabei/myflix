require 'spec_helper'

describe "Deactivate user on failed charge" do
  let(:event_data) do
    {
      "id"=> "evt_177mOP2nDnAL4MMhCjFeluvj",
      "object"=> "event",
      "api_version"=> "2015-10-16",
      "created"=> 1447678053,
      "data"=> {
        "object"=> {
          "id"=> "ch_177mOP2nDnAL4MMh5oiE0YGC",
          "object"=> "charge",
          "amount"=> 999,
          "amount_refunded"=> 0,
          "application_fee"=> nil,
          "balance_transaction"=> nil,
          "captured"=> false,
          "created"=> 1447678053,
          "currency"=> "gbp",
          "customer"=> "cus_7MUoUqC6YBbdwp",
          "description"=> "payment to fail",
          "destination"=> nil,
          "dispute"=> nil,
          "failure_code"=> "card_declined",
          "failure_message"=> "Your card was declined.",
          "fraud_details"=> {},
          "invoice"=> nil,
          "livemode"=> false,
          "metadata"=> {},
          "paid"=> false,
          "receipt_email"=> nil,
          "receipt_number"=> nil,
          "refunded"=> false,
          "refunds"=> {
            "object"=> "list",
            "data"=> [],
            "has_more"=> false,
            "total_count"=> 0,
            "url"=> "/v1/charges/ch_177mOP2nDnAL4MMh5oiE0YGC/refunds"
          },
          "shipping"=> nil,
          "source"=> {
            "id"=> "card_177mNR2nDnAL4MMhNZDi2aWe",
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
            "customer"=> "cus_7MUoUqC6YBbdwp",
            "cvc_check"=> "pass",
            "dynamic_last4"=> nil,
            "exp_month"=> 11,
            "exp_year"=> 2019,
            "fingerprint"=> "OJwh7FIMbilDRNjT",
            "funding"=> "credit",
            "last4"=> "0341",
            "metadata"=> {},
            "name"=> nil,
            "tokenization_method"=> nil
          },
          "statement_descriptor"=> nil,
          "status"=> "failed"
        }
      },
      "livemode"=> false,
      "pending_webhooks"=> 1,
      "request"=> "req_7MVPq76fhdzJxz",
      "type"=> "charge.failed"
    }
  end

  it "deactivates a user with the webhook data from stripe for a failed charge", :vcr do
    alice = Fabricate(:user, customer_token: "cus_7MUoUqC6YBbdwp")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end



   