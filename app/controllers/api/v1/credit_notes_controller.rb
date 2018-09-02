module Api::V1
  class CreditNotesController < ApiController 
    before_action :set_credit_note, only: [:show, :update, :destroy]

    def index
      credit_notes = Vendor.find(vendor_id).credit_notes
      json_response(credit_notes)
    end

    def update
      @credit_note.update(credit_note_params)
      if(@credit_note.save)
        head :no_content
      else
        head :unprocessable_entity
      end
    end

    def create
      begin
        credit_note = CreditNote.new(credit_note_params)
        credit_note[:vendor_id] = vendor_id
        if credit_note.save
          head :created, locatin: v1_credit_note_url(credit_note)
        else
          head :unprocessable_entity
        end
      rescue => e
        json_response({message: e}, :unprocessable_entity)
      end
    end

    def show
      json_response(@credit_note)
    end

    def destroy
      @credit_note.destroy
      head :no_content
    end

    private

    def vendor_id
      params[:vendor_id]
    end

    def credit_note_params
      params.require(:credit_note).permit(
        :total,
        :date,
      )
    end

    def set_credit_note
      @credit_note = CreditNote.find(params[:id])
    end
  end
end
