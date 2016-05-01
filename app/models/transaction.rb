class Transaction < ActiveRecord::Base

  TRANSACTION_PAYMENT_TYPE = "P"
  TRANSACTION_EXPENSE_TYPE = "E"

  validates_presence_of :amount, :message =>"Amount should be more than 0."
  validates_presence_of :paid_to, :message => "User not selected. Please select user to whom you want to pay.", :if => Proc.new { |transaction| transaction.transaction_type == TRANSACTION_PAYMENT_TYPE }

  belongs_to :group


  scope :total_owed_paid, ->{
    select(" sum(transactions.amount) as total, transactions.group_id ").
    group("transactions.group_id")
  }

  scope :total_payment, ->(group_id,user_id) {
    select(" sum(amount) as total ").
    where(["transactions.group_id = ? and 
      transactions.paid_by = ?", group_id, user_id]).
    group("transactions.group_id, transactions.transaction_type")
  }

  
end
