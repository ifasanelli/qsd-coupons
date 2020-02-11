module Api
  module V1
    class CouponsController < Api::V1::ApiController
      def confer
        @coupon = Coupon.find_by!(code: params[:coupon])

        return confer_succesfully if @coupon.confer?(params[:product])

        confer_unsuccesfully
      end

      def confer_succesfully
        discount = @coupon.calculate_discount(params[:price].to_i)
        render json: { discount: discount }, status: :ok
      end

      def confer_unsuccesfully
        render json: { error: @coupon.errors[:base].join },
               status: :unprocessable_entity
      end
    end
  end
end
