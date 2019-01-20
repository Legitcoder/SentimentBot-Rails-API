Rails.configuration.stripe = {
    :publishable_key => 'pk_test_5HdL7hdN6ydVCZjKW7rgtVJo',
    :secret_key => 'sk_test_zMFBUeDaevDQYWlDtZLgoXW7'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]