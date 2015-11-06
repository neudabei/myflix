module StripeWrapper
  class Charge
    def self.create(options = {})
      Stripe::Charge.create(
        amount: options[:amount],
        currency: "usd",
        source: options[:source],
        description: options[:description]
        )
    end
  end
end



# module StripeWrapper
#   class Charge
#     attr_reader :response, :charge

#     def initialize(response, status)
#       @response = response
#       @status = status
#     end

#     def self.create(options = {})
#       StripeWrapper.set_api_key
#       begin
#         response = Stripe::Charge.create(amount: options[:amount], currency: 'usd', source: options[:source], description: options[:description])
#         new(response, :success)
#       rescue Stripe::CardError => e
#         new(e, :error)
#       end
#     end

#     def successful?
#       status == :success
#     end

#     def error_message
#       response.error_message
#     end
#   end

#   def self.set_api_key
#     Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
#   end
# end