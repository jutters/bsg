class ShopFavoritesController < ApplicationController
  #before_action :set_shop_favorite, only: [:show, :edit, :update, :destroy]

  skip_before_action :save_request, only: [ :toggle, :new, :create, :edit, :update, :destroy ]

  def toggle
    user_id = user_session.get_logged_in_user_id();
    shop_id = params[:id];
    favorite = ShopFavorite.where(
      "user_id = :u_id AND shop_id = :s_id", 
      {u_id: user_id, s_id: shop_id}
    )
    logger.debug "+++ searching favorite to toggle - SQL: #{favorite.to_sql}"
    logger.debug "+++ found: #{favorite.count}"
    if favorite.count == 0
      create()
    else
      @shop_favorite = favorite.first()
      destroy()
    end
  end

  # GET /shop_favorites
  # GET /shop_favorites.json
  def index
    @shop_favorites = ShopFavorite.all
  end

  # GET /shop_favorites/1
  # GET /shop_favorites/1.json
  def show
  end

  # GET /shop_favorites/new
  def new
    @shop_favorite = ShopFavorite.new
  end

  # GET /shop_favorites/1/edit
  def edit
  end

  # POST /shop_favorites
  # POST /shop_favorites.json
  def create
    shop = Shop.find(params[:id])
    @shop_favorite = user_session.get_logged_in_user.shop_favorites.build(shop: shop)
    respond_to do |format|
      if @shop_favorite.save
        format.html { restore_last_request(notice: 'Shop favorite was successfully created.') }
        format.json { render :show, status: :created, location: @shop_favorite }
      else
        format.html { render :new }
        format.json { render json: @shop_favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_favorites/1
  # PATCH/PUT /shop_favorites/1.json
  def update
    respond_to do |format|
      if @shop_favorite.update(shop_favorite_params)
        format.html { redirect_to(@shop_favorite, notice: 'Shop favorite was successfully updated.') }
        format.json { render :show, status: :ok, location: @shop_favorite }
      else
        format.html { render :edit }
        format.json { render json: @shop_favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_favorites/1
  # DELETE /shop_favorites/1.json
  def destroy
    @shop_favorite.destroy
    respond_to do |format|
      format.html { restore_last_request(notice: 'Shop favorite was successfully deleted.') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_favorite
      @shop_favorite = ShopFavorite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_favorite_params
      params.require(:shop_favorite).permit(:id)
    end
end
