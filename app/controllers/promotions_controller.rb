class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
    @coupons = @promotion.coupons.where(status: :available)
  end

  def new
    @promotion = Promotion.new
    @products = Product.all
  end

  def create
    @promotion = Promotion.new(promotion_params)
    fill_promotion_fields
    if @promotion.save
      redirect_to @promotion, notice: 'Promoção registrada com sucesso'
    else
      @products = Product.all
      render :new
    end
  end

  def edit
    @products = Product.all
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promoção editada com sucesso'
    else
      @products = Product.all
      render :edit
    end
  end

  def approve
    @promotion = Promotion.find(params[:id])
    return redirect_to root_path, alert: 'Você não pode fazer essa ação'\
      unless @promotion.user != current_user

    @promotion.approve!(current_user)
    redirect_to @promotion, notice: 'Promoção aprovada com sucesso'
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    if @promotion.approved?
      @promotion.issued!
      @promotion.generate_coupons
      flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
    end
    redirect_to @promotion
  end

  private

  def fill_promotion_fields
    @promotion.user = current_user

    return if promotion_params.blank?

    @promotion.product_key = \
      Product.find(promotion_params[:product_id].to_i).key\
  end

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
                                      :discount_percentage, :max_discount_value,
                                      :start_date, :end_date, :max_usage,
                                      :product_id)
  end
end
