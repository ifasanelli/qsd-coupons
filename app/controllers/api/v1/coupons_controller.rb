class Api::V1::CouponsController < Api::V1::ApiController
  def burn_coupon
    @coupon = Coupon.find_by(code: params[:code])
    @coupon.burned!
    render json: @coupon, status: :ok
  end
end