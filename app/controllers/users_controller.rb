class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :show_attendance_status_req]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: [:show, :show_attendance_status_req]
  before_action :admin_or_correct_user, only: [:update, :show, :edit_one_month, :update_one_month]

  def index
    @users = User.paginate(page: params[:page]).where.not(name: @current_user.name)
    
  end
  
    
  
 def csv_import
   if params[:file].present?
    User.import(params[:file])
    flash[:success] = "CSVファイルのインポートが完了しました。"
   else
     flash[:danger] = "CSVファイルを選択してください。"
   end   
    redirect_to root_url
 end 
  
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "編集権限がありません。"
      redirect_to(root_url)
    end
  end  
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @superior = User.where(superior: true).where.not(id: current_user.id)
    # 勤怠変更申請件数の取得
    @attendance_chg_req_sum = User.joins(:attendances).where(attendances: {attendance_chg_status: "申請中", instructor: @user.name}).count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def kintai_member
   @users = User.joins(:attendances).where(attendances: {worked_on: Date.today, finished_at: nil}).where.not(attendances: {started_at: nil})
  end  

  def edit
     
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to users_url
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end
  
  def show_attendance_status_req
    @worked_sum = @attendances.where.not(started_at: nil).count
    @superior = User.where(superior: true).where.not(id: current_user.id)
    # 勤怠変更申請件数の取得
    @attendance_chg_req_sum = User.joins(:attendances).where(attendances: {attendance_chg_status: "申請中", instructor: @user.name}).count
  end   
  
  

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def search
    @users = User.search(params[:keyword]).paginate(page: params[:page])
    
  end
  
  
 

  private
  
    

    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :employee_number, :uid, :password, 
                                   :basic_work_time, :designated_work_start_time, :designated_work_end_time)
    end

    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
 
    # beforeフィルター
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
   
end