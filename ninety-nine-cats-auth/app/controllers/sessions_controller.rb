class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(session_params)

        if @user
            login(user)
            redirect_to cats_url
        else
            render :new
        end

    end

    def destroy
        logout!

        redirect_to new_session_url
       
    end

    private
    def session_params
        params.require(:user).permit(:username, :password)
    end
end