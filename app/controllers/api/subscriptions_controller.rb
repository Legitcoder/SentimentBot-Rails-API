class Api::SubscriptionsController < ApplicationController


  #Create Customer Client on Stripe
  def stripe
    stripe_version = params[:api_version]
    customer_id = current_user.id
    key = Stripe::EphemeralKey.create(
        {customer: customer_id},
        {stripe_version: stripe_version}
    )
    key.to_json
  end

  #Create Subscription
  def create

  end

end
