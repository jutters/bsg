class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :save_request, :authorize_request;

protected

  def authorize_request()
    logger.debug "AUTHORIZE_REQUEST"
    stored_params = user_session.get_stored_params();
    if stored_params != nil
      stored_params[:needs_authorization] = true;
      user_session.store_params(stored_params);
    end
  	unless user_session.logged_in?
  		logger.debug "+++ user not logged in - current params: #{params}"
      logger.debug "+++ redirecting to login..."
  		redirect_to(login_url, notice: "Please log in");
  	end
  end

  def save_request()
    logger.debug "SAVE_REQUEST"
    user_session.store_params(params);
  end

  def restore_last_request(redirect_options = {})
    last_request_params = user_session.get_stored_params();
    if last_request_params == nil
      redirect_to_default_page(redirect_options);
    else
      if !user_session.logged_in? && last_request_params["needs_authorization"]
        redirect_to_default_page(redirect_options);
      else
        redirect_to({
          controller: last_request_params["controller"], 
          action: last_request_params["action"]
          },
          redirect_options
        );
      end
    end
  end

private
 
  helper :layout 
  
  def user_session()
  	@user_session ||= UserSession.new(session)
  end
  helper_method :user_session 


  def redirect_to_default_page(redirect_options)
    if user_session.logged_in?
      redirect_to(admin_path, redirect_options)
    else
      redirect_to(bss_path, redirect_options)
    end
  end
end
