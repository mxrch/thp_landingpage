class MailsController < ApplicationController

	def new
		@mail = Mail.new
	end

	def create
		@mail = Mail.new(mail_params)
		puts @mail.email
		respond_to do |format|
			@mail.save 
				format.html { redirect_to root_url, notice: 'Votre mail a été enregistré.'}
		end
	end

	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail
      @mail = Mail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_params
      params.require(:mail).permit(:email)
    end
end
