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
    @user = current_user
    customer = Stripe::Customer.create(description: @user.email, plan: 'plan_ENJE6m4Jq7vJNz', card: params[:card_token])
    if customer.save
      render :ok, json: {customer: customer}
    else
      render json: { message: "Stripe Customer couldn't be saved." }, status: :unprocessable_entity
    end
  end

  #Cancel subscription at the end of the billing period
  def cancel
    subscription = Stripe::Subscription.retrieve('sub_49ty4767H20z6a')
    subscription.cancel_at_period_end = true
    if subscription.save
      render :ok, json: { message: "Subscription will be canceled at the end of the billing period" }
    else
      render json: { message: "Stripe Customer couldn't be saved." }, status: :unprocessable_entity
    end
  end

end
