class CheckoutController < ApplicationController
  
  def buy_premium_plan
    @session = Stripe::Checkout::Session.create({ 
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: [{ price: 'price_1Lres1DTfT7YasvWl9t8GtWM', quantity: 1 }],
      allow_promotion_codes: true,
      mode: 'payment',
      success_url: root_url + '?session)id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url
     })
     redirect_to @session.url, allow_other_host: true
  end
end
