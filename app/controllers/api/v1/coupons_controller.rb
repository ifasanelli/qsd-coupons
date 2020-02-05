class Api::V1::CouponsController < Api::V1::ApiController

  def index
    @coupons = Coupon.all

    return render json: @coupons, status: :ok
  end

  def confer
    @coupon =
  end
end