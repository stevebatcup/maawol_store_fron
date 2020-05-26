class SubscriptionNotificationsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		@subscription = Subscription.find_by(subscription_id: subscription_id_from_params, platform: params[:platform])
		if @subscription
			notification = @subscription.subscription_notifications.create({
				notification_id: notification_id_from_params,
				method: method_from_params
			})
			forward_on_to_school do |result, message|
				if result
				  status = :success
				else
					status = :error
					message = "Problem contacting school: #{message}"
				end
				notification.update(forward_on_status: status, forward_on_msg: message)
				render json: { status: status, message: message }
			end
		else
			render json: { status: :error, message: "Subscription #{subscription_id_from_params} not found" }
		end
	end

private

	def forward_on_to_school
		url = @subscription.school.callback_url(params[:platform])
		request = {
			headers: {
				'Content-Type': forward_oncontent_type_header
			},
			body: forward_on_body
		}
		response = HTTParty.public_send(:post, url, request)
		if response.code == 200
			yield true, JSON.parse(response.body)['result']
		else
			yield false, response.message
		end
	end

	def forward_on_body
		if params[:platform] == :chargebee
			params.permit!.to_json
		elsif params[:platform] == :paypal
			params.permit!
		end
	end

	def forward_oncontent_type_header
		if params[:platform] == :chargebee
			'application/json'
		elsif params[:platform] == :paypal
			'application/x-www-form-urlencoded'
		end
	end

	def subscription_id_from_params
		if params[:platform] == :chargebee
			params[:content][:subscription][:id]
		elsif params[:platform] == :paypal
			params[:recurring_payment_id]
		end
	end

	def notification_id_from_params
		if params[:platform] == :chargebee
			params[:id]
		elsif params[:platform] == :paypal
			params[:ipn_track_id]
		end
	end

	def method_from_params
		if params[:platform] == :chargebee
			params[:event_type]
		elsif params[:platform] == :paypal
			params[:txn_type]
		end
	end
end