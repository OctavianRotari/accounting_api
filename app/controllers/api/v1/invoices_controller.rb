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
      json_response(invoice)
    end

    def create
      begin
        invoice = Invoice.new(invoice_params)
        invoice.vendor_id = params[:vendor_id]
        if invoice.save
          if(line_items_params)
            create_line_items(invoice)
          end
          if(fuel_receipts_ids_params)
            link_fuel_receipt_to(invoice)
          end
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

    def destroy
      begin
        @invoice.destroy
        head :no_content
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

    def line_items_params
      return false if !params.has_key?(:line_items)
      params.require(:line_items).map do |p|
        p.permit(
          :vat,
          :amount,
          :description,
        )
      end
    end

    def fuel_receipts_ids_params
      return false if !params.has_key?(:fuel_receipts_ids)
      params.require(:fuel_receipts_ids).map { |p| p }
    end

    def create_line_items(invoice)
      line_items_params.map do |line_item_param|
        line_item_param[:invoice_id] = invoice.id
        LineItem.create(line_item_param)
      end
    end

    def link_fuel_receipt_to(invoice)
      fuel_receipts_ids_params.map do |id|
        fuel_receipt = FuelReceipt.find(id)
        LineItem.create_fuel_line_item(fuel_receipt, invoice.id)
      end
    end

    def set_invoice
      @invoice = Invoice.includes(:line_items).find(params[:id])
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
