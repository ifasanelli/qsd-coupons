class PromotionsController < ApplicationController
  def show
    @promotion = Promotion.find_by(params[:id])
    @coupons = @promotion.coupons
  end
end
