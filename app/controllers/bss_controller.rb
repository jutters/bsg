class BssController < ApplicationController

	#layout :determine_layout

	def men
	    filter_shops("shop_type_men_fashion");
	end

	def women
	    filter_shops("shop_type_women_fashion");
	end

	def interior
	    filter_shops("shop_type_interior_design");
	end

private
	def filter_shops(type)
		@shops = Shop.where(type => true).order(:name);
		@insider_shops_count = @shops.select{ |shop| shop.insider_tip? }.count;
	end

	#def determine_layout
		#if current_user_is_logged_in
		#	"standard_logged_in"
		#else
		#	"standard_logged_out"
	#end
end
