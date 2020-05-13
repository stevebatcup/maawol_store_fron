Pony.options = {
	from: 'hello@maawol.com',
	via: :smtp,
  via_options: {
    address: 'smtp.fastmail.com',
    user_name: 'hello@maawol.com',
    password: ENV['FASTMAIL_PASSWORD'],
    port: '587',
  }
}