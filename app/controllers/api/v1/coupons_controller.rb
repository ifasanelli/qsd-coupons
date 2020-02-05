class Api::V1::CouponsController < Api::V1::ApiController
  def use
    p params
    @coupon = Coupon.find_by(code: params[:code])
    p @coupon
    @coupon.burned!
    render json: @coupon, status: :ok
  end
end