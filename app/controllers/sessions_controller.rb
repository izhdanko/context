class SessionsController < ApplicationController

  # layout nil

  skip_before_action :login_required, only: [ :new, :create ]
  before_action :show_tasks_for_user, only: :new


  def new
    # p '[SessionsController]: I am execute, yep!'
    # p session.to_h
    # @session = Session.new
  end

  def create
    # p params

    user = User.authenticate params[:email], params[:password]
    if user
      session[:user_id] = user.id
      redirect_to tasks_path, notice: 'Добро пожаловать в Контекст!'
    else
      # flash[:alert] = ''
      # flash.alert = 'Wrong password' # I18n.t "errors.sessions.wrong_login" # Используется при редиректе.
      flash.now.alert = 'Неверный email или пароль'
      render :new
      # redirect_to login_path
      # redirect_to controller: :sessions, action: :new
      # redirect_to 'sessions/new'
    end

    # render plain: 'I am fine!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Выход из Контекста успешно выполнен!'
  end



  private

  def show_tasks_for_user
    redirect_to tasks_path, notice: 'Добро пожаловать в Контекст!' if current_user
  end

end
