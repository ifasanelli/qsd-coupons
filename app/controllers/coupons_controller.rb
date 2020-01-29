class CouponsController< ApplicationController
  def create
    @promotion = Promotion.find(params[:promotion_id])

    @promotion.max_usage.times do |i|
      code = @promotion.prefix + "000#{i+1}"
      Coupon.create!(code: code, promotion_id: @promotion.id)
    end

    flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
    redirect_to promotion_path(@promotion)
  end
end