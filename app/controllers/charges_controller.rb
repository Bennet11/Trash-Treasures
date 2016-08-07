class ChargesController < ApplicationController

  def create
    buyer = Stripe::Buyer.create(
      name: current_user.name,
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      buyer: buyer.id,
      amount: Amount.default,
      description: "Trash and Treasures Express Payment to #{@post.owner.name}",
      currency: 'usd'
    )

    if charge.paid == true
      current_user.upgrade_account
      flash[:notice] = "Payment Successful!"
      redirect_to post_path(current_user)
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
