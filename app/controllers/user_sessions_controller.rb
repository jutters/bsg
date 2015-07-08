class UserSessionsController < ApplicationController
  
  skip_before_action :save_request, :authorize_request;

  # GET /login
  def new
    ensure_root_admin_exists!
  end

  # POST /login
  def create
  	user = User.find_by(email: params[:email]);
  	if user and user.authenticate(params[:password])
  		user_session.login(user)
      restore_last_request(notice: "Successfully logged in")
  	else
  		redirect_to(login_url, alert: "Invalid user/password combination")
  	end
  end

  # GET /logout
  # DELETE /logout
  def destroy
  	user_session.logout()
  	restore_last_request(notice: "Successfully logged out")
  end

private

  def ensure_root_admin_exists!
    if User.count.zero?
      admin = User.new({email:"admin", username:"admin", password:"init123"});
      admin.save();
    end
  end 

end
