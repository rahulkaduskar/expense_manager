class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @transaction }
    end
  end

  def new
    @transaction = Transaction.new
    @transaction.group_id = params[:group_id]
    @transaction.transaction_type = params[:transaction_type]
    render :layout => false
  end

  def create
    @transaction = Transaction.new(transaction_params(params))
    @transaction.paid_by = current_user.id
    @success = false
    if @transaction.save
      @msg = get_save_msg
      @success = true
      render json: { status: :ok , msg: @msg}
    else      
      @error = @transaction.errors.messages
      render json: { status: :internal_server_error , msg: @msg}
    end    
  end

  private
  def transaction_params(params)
    params.require(:transaction).permit(:amount, :description, :transaction_type, :user_id, :group_id)
  end

  def get_save_msg
    if @transaction.transaction_type == Transaction::TRANSACTION_PAYMENT_TYPE
      return "Payment to #{@transaction.user.name} succcefully done."
    else
      return "Expense recorded succcefully ."
    end
  end
end
