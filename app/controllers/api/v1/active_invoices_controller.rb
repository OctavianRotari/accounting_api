module Api::V1
  class ActiveInvoicesController < ApiController
    before_action :set_active_invoice, only: [:show, :update, :destroy, :fuel_receipts]

    def index
      vendor = Vendor.find(params[:vendor_id])
      active_invoices = vendor.active_invoices
      json_response(active_invoices)
    end

    def show
      active_invoice = @active_invoice.as_json
      active_invoice['sold_line_items'] = @active_invoice.sold_line_items
      json_response(active_invoice)
    end

    def create
      begin
        active_invoice = ActiveInvoice.new(active_invoice_params)
        active_invoice.vendor_id = params[:vendor_id]
        sold_line_items_params["sold_line_items"].map do |sold_line_item| 
          active_invoice.sold_line_items << SoldLineItem.new(sold_line_item) 
        end
        if active_invoice.save
          head :created, location: v1_other_expenses_url(active_invoice)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
      sold_line_items = sold_line_items_params["sold_line_items"]
      if sold_line_items
        update_line_item(sold_line_items)
      else
        if !active_invoice_params["active_invoice"].blank?
          begin
            @active_invoice.update(active_invoice_params)
            if(@active_invoice.save) 
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
        @active_invoice.destroy
        head :no_content
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def destroy_sold_line_item
      begin
        sold_line_items = ActiveInvoice.find(params[:active_invoice_id]).sold_line_items
        if sold_line_items.length == 1
          if sold_line_items.first.id == params[:id].to_i
            json_response({message: 'ActiveInvoice should have at leat one line item'}, :unprocessable_entity)
          end
        else
          sold_line_item = SoldLineItem.find(params[:id])
          sold_line_item.destroy
          head :no_content
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def fuel_receipts
      json_response(@active_invoice.fuel_receipts)
    end

    private
    def active_invoice_params
      params.require(:active_invoice).permit(
        :date,
        :deadline,
        :description,
        :serial_number,
      )
    end

    def sold_line_items_params
      params.require(:active_invoice).permit(
        sold_line_items: [:vat, :total, :description, :id]
      )
    end

    def set_active_invoice
      begin
        @active_invoice = ActiveInvoice.includes(:sold_line_items).find(params[:id])
      rescue => e
        e
      end
    end

    def update_line_item(sold_line_items)
      begin
        sold_line_items.map do |sold_line_item|
          db_line_item = SoldLineItem.find(sold_line_item['id'])
          db_line_item.update(sold_line_item)
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end
  end
end
