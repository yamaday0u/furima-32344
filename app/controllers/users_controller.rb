class UsersController < ApplicationController

  def index #show users ranking 
    @users = User.all
    @rankers = show_rankers_by_orders(@users)
  end

  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

  private
  def show_rankers_by_orders(users)
    ranking = []
    users.each do |user|
      order_count = {user_nickname: user.nickname, orders: user.purchases.count}
      ranking << order_count
    end
    ranking = ranking.sort_by { |ranker| ranker[:orders] }.reverse
    return ranking
  end
end
