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
    @total_paid = Transaction.where(["transactions.transaction_type = ? and paid_by = ?", 
      Transaction::TRANSACTION_EXPENSE_TYPE, current_user.id]).select(" sum(amount) as total ").first
    @groups = Group.joins(:group_members,:transactions).select("groups.name, groups.group_members_count, sum(transactions.amount) as amount ")
    .where(["group_members.user_id = ? and transactions.paid_by != ?", current_user.id, current_user.id]).group("transactions.group_id")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {user: @user , total_paid_owed: @total_paid_owed, total_paid: @total_paid}  }
    end
  end

  # def new
  #   @user = User.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @user }
  #   end
  # end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def create
  #   @user = User.new(user_params(params))
  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to "/", notice: 'User was successfully created.' }
  #       format.json { render json: @user, status: :created, location: @user }
  #     else
  #       format.html { render action: "new" }
  #       format.json { redirect_to :back }
  #     end
  #   end
  # end

  # def update
  #   @user = User.find(params[:id])

  #   respond_to do |format|
  #     if @user.update_attributes(user_params(params))
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy

  #   respond_to do |format|
  #     format.html { redirect_to users_url }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  # def user_params(params)
  #   params.require(:user).permit( :email, :name, :password, :salt, :password_confirmation)
  # end
end
