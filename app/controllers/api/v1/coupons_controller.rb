module Api
  module V1
    class CouponsController < Api::V1::ApiController
      def burn
        @coupon = Coupon.find_by(code: params[:code])
        return head :not_found if @coupon.blank?

        return head :forbidden if @coupon.burned?

        @coupon.burned!
        render json: @coupon, status: :ok
      end
    end
  end
end
