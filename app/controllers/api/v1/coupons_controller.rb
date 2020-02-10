module Api
  module V1
    class CouponsController < Api::V1::ApiController
      def burn
        @coupon = Coupon.find_by(code: params[:code])

        if @coupon.present?
          @coupon.burned!
          render json: @coupon, status: :ok
        else
          head :not_found
        end
      end
    end
  end
end
