module Api::V1
  class InvoicesController < ApiController
    before_action :set_invoice, only: [:show, :update, :destroy, :fuel_receipts]

    def index
      vendor = Vendor.find(params[:vendor_id])
      invoices = vendor.invoices
      json_response(invoices)
    end

    def show
      invoice = @invoice.as_json
      invoice['items'] = @invoice.line_items
      json_response(invoice)
    end

    def create
      begin
        invoice = Invoice.new(invoice_params)
        invoice.vendor_id = params[:vendor_id]
        invoice[:items] = items_params
        if invoice.save
          link_to_vehicle(invoice)
          head :created, location: v1_invoice_url(invoice)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      items = items_params["items"]
      if items
        update_item(line_items)
      else
        if !invoice_params["invoice"].blank?
          begin
            @invoice.update(invoice_params)
            if(@invoice.save)
              head :no_content
            else
              head :unprocessable_entity
            end
          rescue => e
            json_response({message: e}, :unprocessable_entity)
          end
        end
      end
    end

    def destroy
      begin
        @invoice.destroy
        head :no_content
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy_line_item
      begin
        items = Invoice.find(params[:invoice_id]).items
        if items.length == 1
          if items.first.id == params[:id].to_i
            json_response({message: 'Invoice should have at leat one line item'}, :unprocessable_entity)
          end
        else
          item = LineItem.find(params[:id])
          item.destroy
          head :no_content
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
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

    def items_params
      params.require(:invoice).permit(
        items: [:vat, :amount, :description, :id]
      )
    end

    def set_invoice
      begin
        @invoice = Invoice.includes(:items).find(params[:id])
      rescue => e
        e
      end
    end

    def update_item(line_items)
      begin
        items.map do |line_item|
          db_item = LineItem.find(line_item['id'])
          db_item.update(line_item)
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def vehicle_param
      params.require(:invoice).permit(
        :vehicle_id,
      )
    end

    def link_to_vehicle(invoice)
      if(vehicle_param[:vehicle_id])
        vehicle_id = vehicle_param[:vehicle_id]
        invoice.associate_to(vehicle_id)
      end
    end
  end
end
