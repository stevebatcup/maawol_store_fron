class SubscriptionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		if school
			subscription = Subscription.new({
				subscription_id: params[:id],
				platform: params[:platform],
				school_id: school.id,
				status: :active
			})
			if subscription.save
				status = :success
				message = "Subscription #{params[:id]} saved"
			else
				status = :error
				message = subscription.errors.full_messages
			end
		else
			status = :error
			message = not_found_msg
		end
		render json: { status: status, message: message }
	end

	def destroy
		if school
			if subscription = school.subscriptions.find_by(subscription_id: params[:id], status: :active)
				subscription.update(status: :deleted)
				status = :success
				message = "Subscription deleted"
			else
				status = :error
				message = "Subscription not found"
			end
		else
			status = :error
			message = not_found_msg
		end
		render json: { status: status, message: message }
	end

private

	def not_found_msg
		"School not found"
	end

	def school
		validator = SchoolRequestValidator.new(params[:access_token])
		validator.validate
	end
end
