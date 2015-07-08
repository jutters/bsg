class BssController < ApplicationController
	
	before_action :init, only: [:men, :women, :interior]

	skip_before_action :save_request, only: [:login, :logout, :update_shop_filter_settings]
	skip_before_action :authorize_request, only: [:men, :women, :interior, :update_shop_filter_settings, :login, :logout]

	#layout :determine_layout

	layout "bss", except: [ :favorites ]
	layout "bss_favorites", only: [ :favorites ]

	def login
		redirect_to controller: "user_sessions", action: "new";
	end

	def logout
		redirect_to controller: "user_sessions", action: "destroy";
	end

	def men
	    filter_shops("shop_type_men_fashion");
	end

	def women
	    filter_shops("shop_type_women_fashion");
	end

	def interior
	    filter_shops("shop_type_interior_design");
	end

	def update_shop_filter_settings	
		user_session.update_shop_filter_settings(shop_filter_params);
		#redirect_to :action => user_session.get_current_action;
		restore_last_request();
	end

	def favorites
		@shops = user_session.get_favorite_shops();
	end

private 
	def init
		params[:shop_filter_settings] = user_session.get_shop_filter_settings();
	end

	def filter_shops(shop_type)
		Rails.logger.debug "+++ filtering shops with shop_type: '#{shop_type}'...";
		#@shops = Shop.where(type => true).order(:name);
		@shops = user_session.get_filtered_shops(shop_type);
		Rails.logger.debug "+++ filter result: #{@shops}";
		@insider_shops_count = @shops.select{ |shop| shop.insider_tip? }.count;
	end

    def shop_filter_params
      params.require(:shop_filter_settings).permit(
		:price_segment_low,
		:price_segment_middle,
		:price_segment_high,
		:locale_de_shop,
		:locale_foreign_shop_de_website,
		:locale_foreign_shop_de_delivery,
		:brand_type_single,
		:brand_type_multi
      );
    end

	#def determine_layout
		#if current_user_is_logged_in
		#	"standard_logged_in"
		#else
		#	"standard_logged_out"
	#end
end
