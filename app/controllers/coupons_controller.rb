class CouponsController < ApplicationController
  before_action :authenticate_user!

  def create
    @promotion = Promotion.find(params[:promotion_id])
    if @promotion.approved?
      @promotion.generate_coupons
      @promotion.update(status: "issued")
      flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
    end
    redirect_to promotion_path(@promotion)
  end
  def index
    @coupons = Coupons.all
  end

  def show
    @coupon = Coupon.find(params[:promotion_id])
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy
    flash[:notice] = 'Cupom deletado com sucesso'
    redirect_to promotion_path(params[:promotion_id])
  end
end
