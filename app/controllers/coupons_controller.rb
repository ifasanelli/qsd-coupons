class CouponsController < ApplicationController
  def create
    @promotion = Promotion.find(params[:promotion_id])
    @promotion.generate_coupons
    flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
    redirect_to promotion_path(@promotion)
  end
end
