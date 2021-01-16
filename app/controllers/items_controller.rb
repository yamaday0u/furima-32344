class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def new
    @item = Item.new
  end

  def create
    
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :explantion, :image, :category_id, :item_status_id,
      :delivery_fee_id, :shipping_area_id, :days_to_ship_id, :price
    ).merge(user_id: current_user.id)
  end
end
