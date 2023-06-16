class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
   
    def index
      @users = User.all
    end
    
    def update
        user = current_user
        if user.update(user_params)
          redirect_to public_users_show_path, notice: '更新が完了いたしました。'
        else
          redirect_to public_users_edit_path, notice: '更新できませんでした。'
        end
    end
end
