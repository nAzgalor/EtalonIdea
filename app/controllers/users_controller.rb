class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    if params[:user][:password].blank?
      if @user.update_without_password(user_params.except(:password, :password_confirmation))
        redirect_to( categories_path, flash: { success: 'User was successfully updated.' })
      else
        redirect_to categories_path
      end
    else
      if @user.update(user_params)
        sign_in current_user, bypass: true
        redirect_to( categories_path, flash: { success: 'User was successfully updated.' })
      else
        render action: 'edit'
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :role, :password_confirmation)
    end
end
