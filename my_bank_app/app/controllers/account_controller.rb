class AccountController < ApplicationController
  before_action :find_my_account
  def deposit_form; end

  def transfer_form; end
  
  def withdraw_form; end
  
  def statement; end

  def deposit
    @my_account.balance = @my_account.balance + params[:deposit][:amount].to_f
    @transaction = Transaction.new(deposit_params)
    @transaction.transaction_type = 'deposit'
    @transaction.account_to = @my_account.account_no
    if @my_account.save
      if @transaction.save
        flash.now[:alert] = 'Money Deposited'
        redirect_to home_page_path
      else
        flash.now[:alert] = 'Something went wrong!'
        @my_account.balance = @my_account.balance -  params[:deposit][:amount].to_f
        @my_account.update
        redirect_to home_page_path
      end
    else
      flash.now[:alert] = 'Something went wrong!'
      redirect_to home_page_path
    end
  end

  def withdraw
    if @my_account.balance > params[:withdraw][:amount].to_f
      @my_account.balance = @my_account.balance - params[:withdraw][:amount].to_f
      if @my_account.save
        @transaction = Transaction.new(withdraw_params)
        @transaction.transaction_type = 'withdraw'
        @transaction.account_from = @my_account.account_no
        if @transaction.save
          flash.now[:alert] = 'Money Withdrawed'
          redirect_to home_page_path
        else
          flash.now[:alert] = 'Something went wrong!'
          @my_account.balance = @my_account.balance + params[:withdraw][:amount].to_f
          @my_account.update
          redirect_to home_page_path
        end
      else
        flash.now[:alert] = 'Something went wrong!'
        redirect_to home_page_path
      end
    else
      flash.now[:alert] = 'You dont have enough balance!'
      redirect_to home_page_path
    end  
  end

  def transfer
    @transfer_to = Account.find_by(account_no: params[:transfer][:account_to])
    if @transfer_to == nil
      flash.now[:alert] = 'Account not Found You want to transfer to!'
      redirect_to transfer_form_path
    else
      if @my_account.balance > params[:transfer][:amount].to_f
        @my_account.balance = @my_account.balance - params[:transfer][:amount].to_f
        @transfer_to.balance = @transfer_to.balance + params[:transfer][:amount].to_f
        if @my_account.save && @transfer_to.save
          @transaction = Transaction.new(transfer_params)
          @transaction.transaction_type = 'transfer'
          @transaction.account_from = @my_account.account_no
          @transaction.account_to = params[:transfer][:account_to]
          @transaction.save
          flash.now[:alert] = 'Transfer done'
          redirect_to home_page_path
        else
          flash.now[:alert] = 'Something went wrong!'
          redirect_to home_page_path
        end
      else
        flash.now[:alert] = 'You dont have enough balance to transfer!'
        redirect_to home_page_path
      end
    end
  end

  def transaction
    @transactions = Transaction.where(account_to: @my_account.account_no).or(Transaction.where(account_from: @my_account.account_no))
  end

  private
  def find_my_account
    @my_account = Account.find_by(user_id: current_user.id)
  end

  def deposit_params
    params.require(:deposit).permit(:amount)
  end

  def withdraw_params
    params.require(:withdraw).permit(:amount)
  end

  def transfer_params
    params.require(:transfer).permit(:amount, :transfer_to)
  end
end
