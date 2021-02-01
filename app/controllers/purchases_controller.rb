class PurchasesController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!, only: [:index]
  before_action :redirect_user, only: [:index]

  def index
    @purchase = OrderItem.new # indexアクションだが、機能的にはnewアクション
  end

  def create
    @purchase = OrderItem.new(purchase_params)
    if @purchase.valid?
      pay_item # private method
      @purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:order_item).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_user
    redirect_to root_path if (current_user.id == @item.user_id) || @item.purchase.present? # @itemからpurchaseのレコードを取得できるか=購入済みか？
  end
end
