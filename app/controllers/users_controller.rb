class UsersController < ApplicationController
 
  # def index
  #   @users = User.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @users }
  #   end
  # end


  def show
    @user = User.find(params[:id])
    @total_expenses = Transaction.joins(:group => :group_members).where(["transactions.transaction_type = ? and group_members.user_id = ?", 
      Transaction::TRANSACTION_EXPENSE_TYPE, current_user.id]).select(" sum(amount/groups.group_members_count) as total ").first.total
    @total_expenses = 0 if @total_expenses.blank?
    @total_paid = Transaction.where(["transactions.transaction_type = ? and paid_by = ?", 
      Transaction::TRANSACTION_EXPENSE_TYPE, current_user.id]).select(" sum(amount) as total ").first.total
    @groups = Group.joins(:group_members,:transactions).select("groups.name, groups.group_members_count, sum(transactions.amount) as amount ")
    .where(["group_members.user_id = ? and transactions.paid_by != ?", current_user.id, current_user.id]).group("transactions.group_id")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {user: @user , total_paid_owed: @total_paid_owed, total_paid: @total_paid}  }
    end
  end

  def search
    query = "#{ params[:query]}%"
    users = User.where(["name like ? or email like ?", query, query ])
    respond_to do |format|
      format.json { render json: users }
    end

  end

end
