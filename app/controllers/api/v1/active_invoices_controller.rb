module Api::V1
  class ActiveInvoicesController < ApiController
    before_action :set_invoice, only: [:show, :update, :destroy]

    def index
      vendor = Vendor.find(params[:vendor_id])
      active_invoices = vendor.active_invoices
      json_response(active_invoices)
    end

    def show
      active_invoice = @active_invoice.as_json
      json_response(active_invoice)
    end

    def create
      begin
        active_invoice = ActiveInvoice.new(active_invoice_params)
        active_invoice.vendor_id = params[:vendor_id]
        if active_invoice.save
          if(sold_line_items_params)
            create_sold_line_items(active_invoice)
          end
          if(loads_ids_params)
            link_load_to(active_invoice)
          end
          head :created, location: v1_invoice_url(active_invoice)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def update
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

    def destroy
      begin
        @active_invoice.destroy
        head :no_content
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
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
      return false if !params.has_key?(:sold_line_items)
      params.require(:sold_line_items).map do |p|
        p.permit(
          :vat,
          :total,
          :description,
        )
      end
    end

    def loads_ids_params
      return false if !params.has_key?(:loads_ids)
      params.require(:loads_ids).map { |p| p }
    end

    def link_load_to(active_invoice)
      loads_ids_params.map do |id|
        load = Load.find(id)
        SoldLineItem.create_load_line_item(load, active_invoice.id)
      end
    end

    def create_sold_line_items(active_invoice)
      sold_line_items_params.map do |sold_line_item_param|
        sold_line_item_param[:active_invoice_id] = active_invoice.id
        SoldLineItem.create(sold_line_item_param)
      end
    end


    def set_invoice
      @active_invoice = ActiveInvoice.includes(:sold_line_items).find(params[:id])
    end
  end
end
