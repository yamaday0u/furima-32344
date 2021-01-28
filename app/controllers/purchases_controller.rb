class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase = OrderItem.new #indexアクションだが、実質的にはnewアクション
  end

  def create
    
  end
end
