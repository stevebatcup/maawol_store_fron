class Subscription < ApplicationRecord
	belongs_to	:school
	has_many	:subscription_notifications
	enum	status: [:active, :deleted]

	validates_presence_of	:platform, :subscription_id
end
