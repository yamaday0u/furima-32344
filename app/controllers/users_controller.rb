class UsersController < ApplicationController

  def index #show users ranking 
    @rankers = RankingService.rankers_by_order_count(User.all)
    @sales_rankers
    @orders_amount = RankingService.rankers_by_orders_amount(User.includes(:items))
  end

  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

end
