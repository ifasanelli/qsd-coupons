class PromotionsController < ApplicationController
  def show
    @promotion = Promotion.find_by(params[:id])
  end
end
