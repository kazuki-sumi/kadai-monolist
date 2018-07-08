class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    # /users/2といったURLにアクセスされると、params[:id] = 2が代入される
    @user = User.find(params[:id])
    # .uniq 配列の中で重複する要素を削除した新しい配列を返す
    # want, Havaの両方を取得するため@user.items.uniq
    @item = @user.items.uniq
    @count_want = @user.want_items.count
    @count_have = @user.have_items.count
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
