class UserSession

  def initialize(session)
    @session = session;
    @session[:shop_filter_settings] ||= {};
    cached_filter_settings = @session[:shop_filter_settings];
    @shop_filter ||= ShopFilter.new(cached_filter_settings);
    Rails.logger.debug "session initialized.";
    Rails.logger.debug "filter settings (session): #{cached_filter_settings}";
    Rails.logger.debug "filter settings (filter object): #{@shop_filter.get_filter_settings}";
  end

  def get_shop_filter_settings()
    Rails.logger.debug "get_shop_filter_settings - current filter settings: #{@shop_filter.get_filter_settings}";
    @shop_filter.get_filter_settings;
  end

  def get_filtered_shops(shop_type)
    @shop_filter.get_filtered_shops(shop_type);
  end

  def update_shop_filter(settings)
    Rails.logger.debug "update_shop_filter - filter settings: #{settings}";
  	@shop_filter.update_filter_settings(settings);
    @session[:shop_filter_settings] = @shop_filter.get_filter_settings();
    Rails.logger.debug "updated filter settings (local): #{@shop_filter.get_filter_settings}";
    Rails.logger.debug "updated filter settings (session): #{@session[:shop_filter_settings]}";
  end

  def set_current_action(action)
  	@session[:bss_action] = action;
  end

  def get_current_action()
  	@session[:bss_action];
  end
end