class SessionsController < ApplicationController
  def new
  end
  
  # ログイン情報保存アクション
  def create
    # form_forで送られてきたemailがparamsに代入され、二段階指定で取得。downcaseで小文字化。
    email = params[:session][:email].downcase
    # emailと同じ
    password = params[:session][:password]
    if login(email, password)
      # redirect_toの前ならflash
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      # renderの前ならflash.now
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    # session[:user_id] = @user.idを削除すればいい。よって値がないnilを代入する。
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private
  
  # ログイン用アクション
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      #ログイン失敗
      return false
    end
  end
  
end
