class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
    # @user = User.find(params[:user_id])
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    # @user = User.find(params[:user_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user = current_user
    @review.save
    redirect_to restaurants_path
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  # def user_params
  #   params.require(:user).permit(:email)
  # end
end
