class PurchasesController < ApplicationController
  def index
    @purchase = OrderItem.new #indexアクションだが、実質的にはnewアクション
  end

  def create
    
  end
end
