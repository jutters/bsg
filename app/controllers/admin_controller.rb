class AdminController < ApplicationController
  def index
  	@total_shops = Shop.count;
  end
end
