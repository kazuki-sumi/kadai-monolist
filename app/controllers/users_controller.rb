class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    # /users/2といったURLにアクセスされると、params[:id] = 2が代入される
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  # Strong Parameter(このクラス内のみで使用できるメソッド)
  # 必要なパラメータを把握し、送信されてきたデータを精査する
  # params.require(:user)でUserモデルのフォームから得られるデータと明示
  # .permit()で必要なカラムを選択
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
