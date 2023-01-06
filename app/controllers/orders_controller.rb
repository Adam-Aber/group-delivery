class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show ]

  def index
    @orders = Order.all
  end

  def show
    order = Order.find(params[:id])
    @orders = Order.where(address: order.address, restaurant: order.restaurant)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: "Order was successfully created." }
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
