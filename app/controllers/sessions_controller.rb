class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to todos_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスかパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "ログアウトしました"
  end
end
