class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(session_params)
        session[:session_token] = user.reset_session_token!
        redirect_to cats_url
    end

    def destroy
        if logged_in?
            @current_user.reset_session_token!
            session[:session_token] = nil
        end

        redirect_to new_session_url
    end

    private
    def session_params
        params.require(:session).permit(:username, :password)
    end
end