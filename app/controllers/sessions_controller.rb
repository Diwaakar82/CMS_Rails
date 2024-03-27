class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:user][:email].downcase)
        if @user && @user.authenticate(params[:user][:password])
            reset_session
            session[:current_user_id] = @user.id
            redirect_to authenticated_root_path, notice: "Logged in"
        else
            flash.now[:alert] = "Incorrect email or password"
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
        @user = current_user
    end

    def update
        @user = current_user

        if @user.update(user_params)
            redirect_to authenticated_root_url
        else
            render 'edit'
        end
    end

    def destroy
        reset_session
        redirect_to login_url
    end

private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
