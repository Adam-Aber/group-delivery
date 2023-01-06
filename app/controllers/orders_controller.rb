class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]

  def index
    @orders = Order.all
  end

  def show
    current_order = Order.find(params[:id])
    orders = check_location(current_order)
    check_time(orders, current_order)
  end

  def check_location(order)
    Order.where(address: order.address, restaurant: order.restaurant)
  end

  def check_time(orders, current_order)
    @just_ordered = []
    orders.each do |order|
      difference = current_order.created_at.to_time.to_i - order.created_at.to_time.to_i
      minutes = (difference % 3600) / 60
      @just_ordered << order if difference >= 0 && minutes <= 10
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_path(@order), notice: 'Order was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :address, :contact, :restaurant)
  end
end
