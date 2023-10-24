Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # ユーザー検索
  get 'search', to: 'users#search'

  resources :users do
    member do
      # 勤怠の基本情報編集
      get 'edit_basic_info'
      patch 'update_basic_info'
      # 出勤中社員一覧
      get 'kintai_member'
      # 勤怠編集
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      # 勤怠変更申請
      get 'attendances/show_attendance_chg_req'
      patch 'attendances/update_attendance_chg_req'
       # 勤怠変更申請者の勤怠確認
      get 'show_attendance_status_req'
      # 残業申請
      get 'attendances/edit_overtime_application_req' 
      patch 'attendances/update_overtime_application_req'
    end
    collection do
      # CSVインポート
      post :csv_import
    end  
    resources :attendances 
    
  end 
  
  
  # 拠点情報
  resources :bases
      
  
end
