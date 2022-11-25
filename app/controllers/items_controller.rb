class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def index
    if params[:user_id]
      user= User.find(params[:user_id])
      items = user.items
    else
    items = Item.all 
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id]
      user= User.find(params[:user_id])
      item= user.items.find(params[:id])
    else
    item=Item.find(params[:id])
    end
    render json: item
  end

  def create
    # user = User.find(params[:user_id])
    item=Item.create(item_params)
    render json: item, status: :created
  end

  private
  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def render_not_found(ex)
    render json: {error: "User not found"}, status: :not_found
  end
end
