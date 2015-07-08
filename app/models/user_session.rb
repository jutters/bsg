class UserSession

  def initialize(session)
    Rails.logger.debug "UserSession.initialize()"
    @session = session;
    @session[:shop_filter_settings] ||= {};
    cached_filter_settings = @session[:shop_filter_settings];
    @shop_filter ||= ShopFilter.new(cached_filter_settings);
    Rails.logger.debug "session initialized.";
    Rails.logger.debug "logged in: #{logged_in?}"
    Rails.logger.debug "filter settings (session): #{cached_filter_settings}";
    Rails.logger.debug "filter settings (local filter object): #{@shop_filter.get_filter_settings}";
  end

  def get_shop_filter_settings()
    settings = @shop_filter.get_filter_settings;
    Rails.logger.debug "UserSession.get_shop_filter_settings(): #{settings}";
    settings;
  end

  def update_shop_filter_settings(settings)
    Rails.logger.debug "UserSession.update_shop_filter_settings(): #{settings}";
    @shop_filter.update_filter_settings(settings);
    updated_settings = @shop_filter.get_filter_settings();
    @session[:shop_filter_settings] = updated_settings;
    Rails.logger.debug "updated shop filter settings: #{updated_settings}";
  end

  def get_filtered_shops(shop_type)
    shops = @shop_filter.get_filtered_shops(shop_type);
    Rails.logger.debug "UserSession.get_filtered_shops: #{shops}";
    shops;
  end

  def set_current_action(action)
  	@session[:bss_action] = action;
  end

  def get_current_action()
  	@session[:bss_action];
  end

  def login(user)
    @session[:user_id] = user.id;
  end

  def logout()
    @session[:user_id] = nil;
  end

  def get_logged_in_user()
    User.find_by(id: @session[:user_id]);
  end

  def get_logged_in_user_name()
    user = get_logged_in_user
    if user != nil
      username = user.username
    else
      username = "anonymous"
    end
  end

  def get_logged_in_user_id()
    user = get_logged_in_user
    if user != nil
      userid = user.id
    else
      userid = nil
    end
  end

  def logged_in?
    User.find_by(id: @session[:user_id]) != nil
  end

  def get_favorite_shops()
    Rails.logger.debug "UserSession.get_favorite_shops()..."
    user = get_logged_in_user();
    if user == nil
      Rails.logger.debug "result: nil (as user is not logged in)"
      return nil;
    else
      shops = [];
      user.shop_favorites.find_each do |favorite|
        shops << Shop.find(favorite.shop_id)
      end
      Rails.logger.debug "result: #{shops}"
      shops;
    end
  end

  def store_params(params)
    Rails.logger.debug "UserSession.store_params(): #{params}"
    @session[:request_params] = params;
  end

  def get_stored_params()
    Rails.logger.debug "UserSession.get_stored_params()..."
    params = @session[:request_params];
    Rails.logger.debug "result: #{params}"
    params;
  end

end