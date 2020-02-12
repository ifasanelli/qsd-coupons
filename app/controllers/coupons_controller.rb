class CouponsController < ApplicationController
  before_action :authenticate_user!

  def show
    @promotion = Promotion.find(params[:id])
    @coupon = Coupon.find(params[:promotion_id])
    redirect_to promotion_path(@promotion) if @coupon.unavailable?
  end

  def discard
    @promotion = Promotion.find(params[:promotion_id])
    @coupon = Coupon.find(params[:id])
    @coupon.unavailable!
    flash[:notice] = 'Cupom deletado com sucesso'
    redirect_to promotion_path(@promotion)
  end
end
