class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase = OrderItem.new #indexアクションだが、実質的にはnewアクション
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase = OrderItem.new(purchase_params)
    if @purchase.valid?
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
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
