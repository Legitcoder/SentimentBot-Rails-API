Rails.configuration.stripe = {
    :publishable_key => 'pk_live_tnzRdA4TVuRlALEhALMWgCSl',
    :secret_key => 'sk_live_VYJeofDP0T87hLQBZ0kpiRXX'
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]