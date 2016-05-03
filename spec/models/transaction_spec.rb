require 'rails_helper'
require 'spec_helper'

RSpec.describe Transaction, type: :model do
   before :each do
    @transaction = create(:transaction)

  end

  it "should be valid with a transation payment" do
    @transaction.transaction_type = Transaction::TRANSACTION_PAYMENT_TYPE
    expect(@transaction).to be_valid 
  end

   it "should be valid with a transation expense" do
    @transaction.transaction_type = Transaction::TRANSACTION_EXPENSE_TYPE
    expect(@transaction).to be_valid 
  end

  it "should not valid with a transation type" do
    expect(@transaction).to be_valid 
  end

  it "should not valid with a amount 0" do
    @transaction.transaction_type = Transaction::TRANSACTION_EXPENSE_TYPE
    expect(@transaction).to be_valid 
  end

end
