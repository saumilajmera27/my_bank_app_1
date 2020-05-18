class UserController < ApplicationController
  def index
  end
  
  def home 
    @my_account = Account.find_by(user_id: current_user.id)
  end

  def open_account
    @account = Account.new()
    @account.user_id = current_user.id
    @account.account_no = current_user.contact_no.to_s
    if @account.save
      flash.now[:alert] = 'Congratulations! Account Opened'
      redirect_to home_page_path
    else
      flash.now[:alert] = 'Something went wrong!'
      redirect_to home_page_path
    end
  end
  
end
