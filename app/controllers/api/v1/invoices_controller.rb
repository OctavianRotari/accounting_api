module Api::V1
  class InvoicesController < ApiController
    before_action :set_invoice, only: [:show, :update, :destroy, :fuel_receipts]

    def index
      vendor = Vendor.find(params[:vendor_id])
      invoices = vendor.invoices
      json_response(invoices)
    end

    def create
      begin
        invoice = Invoice.new(invoice_params)
        invoice.vendor_id = params[:vendor_id]
        line_items_params["line_items"].map do |line_item| 
          invoice.line_items << LineItem.new(line_item) 
        end
        if invoice.save
          head :created, location: v1_other_expenses_url(invoice)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      line_items = line_items_params["line_items"]
      if line_items
        update_line_item(line_items)
      else
        if !invoice_params["invoice"].blank?
          @invoice.update(invoice_params)
          if(@invoice.save) 
            head :no_content
          else
            head :unprocessable_entity
          end
        end
      end
    end

    def destroy
      @invoice.destroy
      head :no_content
    end

    def fuel_receipts
      json_response(@invoice.fuel_receipts)
    end

    private
    def invoice_params
      params.require(:invoice).permit(
        :date,
        :deadline,
        :description,
        :serial_number,
      )
    end

    def line_items_params
      params.require(:invoice).permit(
        line_items: [:vat, :amount, :description, :id]
      )
    end

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def update_line_item(line_items)
      if line_items.length == 0
        json_response({message: 'Line items cannot be empty'}, :unprocessable_entity)
      else
        begin
        line_items.map do |line_item|
          db_line_item = LineItem.find(line_item['id'])
          db_line_item.update(line_item)
        end
        rescue => e
          json_response({message: e}, :unprocessable_entity)
        end
      end
    end
  end
end
