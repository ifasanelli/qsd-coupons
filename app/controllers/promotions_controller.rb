class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
    @coupons = @promotion.coupons
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    @promotion.user = current_user
    if @promotion.save
      redirect_to @promotion, notice: 'Promoção registrada com sucesso'
    else
      render :new
    end
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promoção editada com sucesso'
    else
      render :edit
    end
  end

  def approve
    @promotion = Promotion.find(params[:id])
    return redirect_to root_path, alert: 'Você não pode fazer essa ação'\
      unless @promotion.user != current_user

    @promotion.approved!
    redirect_to @promotion, notice: 'Promoção aprovada com sucesso'
  end

  private

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
                                      :discount_percentage, :max_discount_value,
                                      :start_date, :end_date, :max_usage)
  end
end
