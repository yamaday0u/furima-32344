class UsersController < ApplicationController

  def index #show users ranking 
    @trading_amount = RankingService.rankers_by_trading_amount(User.includes(:items))
    @trading_count = RankingService.rankers_by_trading_count(User.includes(:items))
    @sales_amount = RankingService.rankers_by_sales_amount(User.includes(:items))
    @sale_count = RankingService.rankers_by_sale_count(User.includes(:items))
    @orders_amount = RankingService.rankers_by_orders_amount(User.includes(:items))
    @order_count = RankingService.rankers_by_order_count(User.all)
  end

  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

end
