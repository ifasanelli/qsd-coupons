class Api::V1::CouponsController < Api::V1::ApiController
  def confer
    coupon = Coupon.find_by!(code: params[:coupon])

    if coupon.confer?(params[:product])
      discount = coupon.calculate_discount(params[:price].to_i)
      render json: { discount: discount }, status: :ok
    else
      render json: { error: coupon.errors[:base].join }, status: 422
    end
  end
end