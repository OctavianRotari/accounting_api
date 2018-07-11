module Expenses
  module Payable
    extend ActiveSupport::Concern
    included do
      has_and_belongs_to_many :payments
    end

    def create_payment(payment)
      total_payments = self.payments.sum(:total)
      if(payment[:total].to_d > self.total - total_payments)
        raise "The payment total is bigger than the salary total"
      else
        self.payments.create(payment)
      end
    end

    def paid?
      total_payments = self.payments.sum(:total)
      self.total === total_payments ? true : false;
    end

    def total_paid
      payments = self.payments
      payments.sum(:total).to_f
    end
  end
end
