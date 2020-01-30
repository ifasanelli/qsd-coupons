class CouponsController < ApplicationController
  def create
    @promotion = Promotion.find(params[:promotion_id])
    if @promotion.approved?
      @promotion.generate_coupons
      flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
      redirect_to promotion_path(@promotion)
    else
      flash[:notice] = "Promoção inválida "
    end
  end
end
