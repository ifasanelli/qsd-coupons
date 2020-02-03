class CouponsController < ApplicationController
  def create
    @promotion = Promotion.find(params[:promotion_id])
    if @promotion.approved?
      @promotion.generate_coupons
      @promotion.status = "issued"
      flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
    end
    redirect_to promotion_path(@promotion)
  end
  def index
    @cupons = Coupons.all
  end

  def show
    @cupons = Coupon.find(params[:promotion_id])
  end
end
