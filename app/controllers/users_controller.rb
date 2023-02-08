class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context) }
    end
  end

  def show; end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to user_url(@user), notice: 'User was successfully updated.'
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user

    redirect_to users_path, notice: t('labels.delete_user_success') if @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :birthdate, role_ids: [])
  end
end
