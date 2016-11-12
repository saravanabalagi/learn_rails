class MessagingService

  def self.faraday_msg91_post(api_path, json)
    faraday = Faraday.new(:url => 'https://sendotp.msg91.com', :ssl => {:ca_file => Rails.root.join('lib/cacert.pem').to_s }) do |faraday|
      faraday.response :logger, ::Logger.new(STDOUT), bodies: true
      faraday.adapter Faraday.default_adapter
    end
    faraday.post do |req|
              req.url api_path
              req.headers['Content-Type'] = 'application/json'
              req.headers['Application-Key'] = ENV['MSG91_APP_ID']
              req.body = json.to_json
    end
  end

  def self.send_otp?(mobile_number)
    status = false
    begin
      response = faraday_msg91_post('/api/generateOTP',{
            countryCode: '91',
            mobileNumber: mobile_number,
            getGeneratedOtp: true
        })
      json = response.body && response.body.length >= 2 ? JSON.parse(response.body) : nil
      status = true if json['status'] == 'success' && json['response']['code'] == 'OTP_SENT_SUCCESSFULLY'
    rescue => exception
      puts 'Exception thrown during send_otp: ' + exception.class.name
      puts exception
    ensure
      return status
    end
  end

  def self.verify_otp?(mobile_number, otp)
    status = false
    begin
      response = faraday_msg91_post('/api/verifyOTP', {
            countryCode: '91',
            mobileNumber: mobile_number,
            oneTimePassword: otp
        })
      json = response.body && response.body.length >= 2 ? JSON.parse(response.body) : nil
      status = true if json['status'] == 'success' && json['response']['code'] == 'NUMBER_VERIFIED_SUCCESSFULLY'
    rescue => exception
      puts 'Exception thrown during verify_otp: ' + exception.class.name
      puts exception
    ensure
      return status
    end
  end

end
