module Profits
  module Cashable
    extend ActiveSupport::Concern
    included do
      has_and_belongs_to_many :revenues
    end

    def create_revenue(revenue)
      total_revenues = self.revenues.sum(:total)
      if(revenue[:total].to_d > self.total - total_revenues)
        raise 'The profit is bigger than the total to receive'
      else
        self.revenues.create(revenue)
      end
    end

    def cashed?
      total_revenues = self.revenues.sum(:total)
      self.total === total_revenues
    end

    def total_cashed
      revenues = self.revenues
      revenues.sum(:total).to_f
    end
  end
end
