class ContributionType < ApplicationRecord
  belongs_to :user, optional: true
  has_many :financial_contributions
end
