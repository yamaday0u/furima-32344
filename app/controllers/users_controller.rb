class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
  end
end
