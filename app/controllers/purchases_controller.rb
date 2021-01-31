class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase = OrderItem.new #indexアクションだが、実質的にはnewアクション
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = OrderItem.new(purchase_params)
    if @purchase.valid?
      pay_item #private method
      @purchase.save
      redirect_to root_path
    else
       render action: :index
    end
  end

  private
  def purchase_params
    params.require(:order_item).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number,
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: Item.find(purchase_params[:item_id]).price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
