class SchoolRequestValidator
	attr_accessor :access_token

	def initialize(access_token)
		self.access_token = access_token
	end

	def validate
		School.find_by(access_token: access_token)
	end
end