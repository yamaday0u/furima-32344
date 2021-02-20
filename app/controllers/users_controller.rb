class UsersController < ApplicationController

  def index #show users ranking 
    @rankers = RankingService.show_rankers_by_orders(User.all)
  end

  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

end
