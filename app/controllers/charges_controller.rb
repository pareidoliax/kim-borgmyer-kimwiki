class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create

    customer = Stripe::Customer.create(
      email: current_user.email,
      card:  params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      Amount.default,
      description: "Premium Membership #{current_user.email}",
      currency:    'usd'
    )

    current_user.update_attribute(:premium, Time.now)

    flash[:success] = "Thank you for choosing the Premium Membership, #{current_user.email}."
    redirect_to wikis_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key:         "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership #{current_user.email}",
      amount:      Amount.default
    }
  end
end
