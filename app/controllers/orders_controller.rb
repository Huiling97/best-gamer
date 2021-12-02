class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @order.slot = Slot.find(params[:slot_id].to_i)
    @slot = @order.slot
    @order.paid_amount = @slot.duration * @slot.user.rates
  end

  def create
    raise
    @slot = Slot.find(params[:slot_id])
    @order = Order.new(order_params)
    @order.slot = @slot
    @order.user = current_user
    @order.paid_amount = @order.slot.user.rates * @order.duration

    if @order.save!
      @order.slot.booked = true
      @order.slot.save
      redirect_to slot_order_path(@slot, @order)
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = current_user.orders
  end


  private

  def order_params
    params.require(:order).permit(:slot_id)
  end
end
