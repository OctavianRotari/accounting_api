require 'swagger_helper'

describe 'OtherExpense API' do
  path '/v1/other_expenses' do
    post 'Creates a Other Expense'  do
      tags 'Other Expense'
      consumes 'application/json'
      security [bearer: []]
      parameter name: :other_expense, in: :body, schema: {
        type: :object,
        properties: {
          desc: { type: :string },
          total: { type: :decimal }
        },
        required: [ 'desc', 'total' ]
      }

      response '201', 'other_expense created' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:other_expense) { attributes_for(:other_expense) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:other_expense) { { desc: nil, total: nil } }
        run_test!
      end
    end
  end
end
