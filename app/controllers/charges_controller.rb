class ChargesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    if post.number > 0
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
        post.decrement!(:number)
        # what is the value of this attribute?
        post.sold
        flash[:notice] = "Payment Successful!"
        redirect_to post_path(post)
      end
    else
      flash[:alert] = "Item has been sold"
      redirect_to post_path(post)
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
