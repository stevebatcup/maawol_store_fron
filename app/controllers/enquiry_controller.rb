class EnquiryController < ApplicationController
	def create
		# return render json: { status: :error, error: "Ooops no..." } if params[:sweets].length > 0

		if params[:email].length > 0
			Pony.mail({
				to: "steve@maawol.com",
				subject: "New Maawol brochure enquiry from #{params[:email]}",
				html_body: "Hi Steve,<br /><br />You have a new Maawol brochure enquiry from #{params[:name]} <a href='#{params[:email]}'>#{params[:email]}</a>
					<hr /><br />#{params[:message]}"
			})
		end
		render json: { status: "success" }
	end
end