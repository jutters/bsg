class BssController < ApplicationController

	#layout :determine_layout

	def index
	    @shops = Shop.order(:name)
	end

private
	#def determine_layout
		#if current_user_is_logged_in
		#	"standard_logged_in"
		#else
		#	"standard_logged_out"
	#end
end
