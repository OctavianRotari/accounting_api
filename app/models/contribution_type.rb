class ContributionType < ApplicationRecord
  belongs_to :user
  has_many :financial_contributions
end
