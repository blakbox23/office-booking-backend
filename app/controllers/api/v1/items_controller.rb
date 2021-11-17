class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.all
    render json: @items
  end

  def show
    item_id = params[:id]
    @item = Item.find(item_id)
    render json: @item
  end

  def create
    @item_to_save = Item.new(item_params)

    if @item_to_save.save
      render json: { success: 'Item saved' }
    else
      render json: { error: 'Unable to save item' }
    end
  end

  def destroy
    @item_to_delete = Item.find(params[:id])

    if @item_to_delete.destroy
      @updated_items = Item.all
      render json: @updated_items
    else
      render json: { error: 'Item is not in storage or has been deleted' }
    end
  end

  private

  def item_params
    params.permit(:name, :location, :description)
  end
end