class ChargesController < ApplicationController

  def create
    #binding.pry
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: params[:amount],
      description: "Trash and Treasures Express Payment",
      currency: 'usd'
    )

    if charge.paid == true
      flash[:notice] = "Payment Successful!"
      redirect_to :back
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
