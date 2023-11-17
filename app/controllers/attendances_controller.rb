class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :set_one_month, only: :edit_one_month
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  APPROVAL_STS_NON = "なし"
  APPROVAL_STS_APL = "申請中"
  APPROVAL_STS_OK  = "承認"
  APPROVAL_STS_NG  = "否認"
 

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end  
    end
    redirect_to @user
  end
  
  def edit_one_month
    @superiors = User.where(superior: true).where.not(id: current_user.id)
  end  
  
  def show_attendance_chg_req
    @user = User.find(params[:id])
    @applicants = User.joins(:attendances).where(attendances: {attendance_chg_status: APPROVAL_STS_APL, instructor: @user.name}).distinct
    
  end
  
  def update_attendance_chg_req
    ActiveRecord::Base.transaction do
    attendance_chg_req_params.each do |id, item|
     # 指示者確認㊞ が設定されている場合のみ、変更有効
     # 指示者確認㊞ を選択している場合のみチェックを行う
     if item[:chg_permission] == "1"
       
      
         
        attendance = Attendance.find(id)
        case item[:attendance_chg_status] 
          when "申請中"
          
          when "承認"
          attendance.started_at = attendance.chg_started_at
          attendance.finished_at = attendance.chg_finished_at
          attendance.chg_started_at = nil
          attendance.chg_finished_at = nil
          attendance.attendance_chg_status = APPROVAL_STS_OK
          attendance.chg_permission = true
          when "否認", "なし"
          attendance.chg_started_at = nil
          attendance.chg_finished_at = nil
          attendance.attendance_chg_status = APPROVAL_STS_NG
          attendance.chg_permission = true
          else
          
        end
        attendance.save
     end  
    end 
  end
    flash[:success] = "勤怠申請変更の支持者確認を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  
  rescue RuntimeError
    flash[:danger] = "支持者確認㊞のみでの更新は出来ません。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
　end  
    
  end   
  
  def edit_overtime_application_req
    @user = User.find(params[:id])
    @date = params[:date].to_date
    @attendance = @user.attendances.find_by(worked_on: @date )
    @superiors = User.where(superior: true).where.not(name: @user.name)
  end 
  
  def update_overtime_application_req
    @user = User.find(params[:id])
    @date = params[:date]
    @attendance = Attendance.find_by(user_id: @user.id, worked_on: @date)
    
    @attendance.overtime_at = params[:attendance][:overtime_at]
    @attendance.overtime_note = params[:attendance][:overtime_note]
    @attendance.new_instructor = params[:attendance][:new_instructor]
    @attendance.workedhours = params[:attendance][:workedhours]
    @attendance.overtime_hours = params[:attendance][:overtime_hours]
    
    @attendance.save
    flash[:success] = "残業申請を致しました。"
    redirect_to user_url
  end
 
  def edit_overtime_applied_req
      @user = User.find(params[:id])
      @applicants = Attendance.where( new_instructor: current_user.name )
  end  
  
  def update_overtime_applied_req
    @user = User.find(params[:user_id])
  end  
  
def update_one_month
  ActiveRecord::Base.transaction do
    attendances_params.each do |id, item|
     # 指示者確認㊞ が設定されている場合のみ、変更有効
     # 指示者確認㊞ を選択している場合のみチェックを行う
     
     if item[:instructor].present?
       
      
        if (item[:started_at].blank? && item[:finished_at].present?) ||
           (item[:started_at].present? && item[:finished_at].blank?)
         
           raise RuntimeError  
        end   
        attendance = Attendance.find(id)
        attendance.chg_started_at = item[:started_at]
        attendance.chg_finished_at = item[:finished_at]
        attendance.note = item[:note]
        attendance.instructor = item[:instructor]
        attendance.attendance_chg_status = APPROVAL_STS_APL
        attendance.save
     end  
    end 
  end
  flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
  redirect_to user_url(date: params[:date])
rescue ActiveRecord::RecordInvalid
  flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
  redirect_to attendances_edit_one_month_user_url(date: params[:date])
  
rescue RuntimeError
  flash[:danger] = "出勤時間、または退勤時間のみでの更新は出来ません。"
  redirect_to attendances_edit_one_month_user_url(date: params[:date])
end  
  
  
  private
    
   def attendances_params
    params.require(:user).permit(attendances: [:started_at, :finished_at, :note, :instructor])[:attendances]
   end
   
   def attendance_chg_req_params
    params.require(:user).permit(attendances: [:attendance_chg_status, :chg_permission])[:attendances]
   end
   
   def attendance_overtime_application_req
    params.require(:user) .permit(attendances: [:overtime_at, :overtime_note, :workedhours, :overtime_hours])[:attendances]
   end  
end
