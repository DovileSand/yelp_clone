class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user

    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user == current_user
       @restaurant.update(restaurant_params)
       flash[:notice] = 'Restaurant updated successfully'
    else
        flash[:notice] = 'You cannot edit restaurant that you did not create'
    end
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user == current_user
       @restaurant.destroy
       flash[:notice] = 'Restaurant deleted successfully'
    else
        flash[:notice] = 'You cannot delete restaurant that you did not create'
    end
    redirect_to '/restaurants'
  end
end
