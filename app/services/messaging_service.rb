class MessagingService

  def self.faraday_msg91_post(api_path, json)
    Faraday.new(:url => 'https://sendotp.msg91.com', :ssl => {:ca_file => Rails.root.join('lib/cacert.pem').to_s })
                        .post do |req|
                          req.url api_path
                          req.headers['Content-Type'] = 'application/json'
                          req.headers['Application-Key'] = ENV['MSG91_APP_ID']
                          req.body = json.to_json
    end
  end

  def self.send_otp?(user)
    status = false
    begin
      response = faraday_msg91_post('/api/generateOTP',{
            countryCode: '91',
            mobileNumber: user.mobile,
            getGeneratedOtp: true
        })
      json = response.body && response.body.length >= 2 ? JSON.parse(response.body) : nil
      if json['status'] == 'success' && json['response']['code'] == 'OTP_SENT_SUCCESSFULLY'
        status = true
      else
        user.errors.clear
        user.errors.add(:otp, json['response']['code'].humanize)
      end
    rescue => exception
      puts 'Exception thrown during send_otp: ' + exception.class.name
      puts exception
    ensure
      return status
    end
  end

  def self.verify_otp?(user, otp)
    status = false
    begin
      response = faraday_msg91_post('/api/verifyOTP', {
            countryCode: '91',
            mobileNumber: user.mobile,
            oneTimePassword: otp
        })
      json = response.body && response.body.length >= 2 ? JSON.parse(response.body) : nil
      if json['status'] == 'success' && json['response']['code'] == 'NUMBER_VERIFIED_SUCCESSFULLY'
        user.update_attribute(:verified_at, response.headers['date'])
        status = true
      else
        user.errors.clear
        user.errors.add(:otp, json['response']['code'].humanize)
      end
    rescue => exception
      puts 'Exception thrown during verify_otp: ' + exception.class.name
      puts exception
    ensure
      return status
    end
  end

end
