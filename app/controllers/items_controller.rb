class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    unless current_user.id == @item.user.id && @item.purchase.nil?
      redirect_to root_path
    end
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path(@item.id)
    else
      render 'edit'
    end
  end

  def destory
    @item.destory
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :explanation,
      :image,
      :category_id,
      :item_status_id,
      :delivery_fee_id,
      :shipping_area_id,
      :days_to_ship_id,
      :price
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
