module Api::ApiHelper
  require 'digest/md5'
  require 'base64'
  
  API_AUTH_GRANT_TYPE_REFRESH = "refresh"  
  API_AUTH_GRANT_TYPE_AUTH_CODE = "auth_code"  
  API_AUTH_GRANT_TYPES = [Api::ApiHelper::API_AUTH_GRANT_TYPE_REFRESH, Api::ApiHelper::API_AUTH_GRANT_TYPE_AUTH_CODE]
  API_SCOPE_BASIC = "basic"

  API_SUPPORTED_SCOPES = [Api::ApiHelper::API_SCOPE_BASIC]
  API_ACCESS_TOKEN_EXPIRED_MINS = 24*60
  
  LEGAL_BOOLEAN_VALUES = [true, false, "true", "false"]
  
  def self.access_token_expired
    Time.now + Api::ApiHelper::API_ACCESS_TOKEN_EXPIRED_MINS * 60  
  end
  
  def self.api_token_exipred_time(minutes=120)
    minutes.present? && minutes.to_i > 0 ? minutes*60 : 120*60 
  end
    
  def self.is_expired_time(dt_time)
    dt_time.present? && dt_time.utc < Time.now.utc
  end  
  
  def self.get_expires_in(dt_time)
    dt_time.present? ? (dt_time.utc - Time.now.utc).to_i : self.default_expires_in
  end
  
  def self.default_expires_in
    Api::ApiHelper::API_ACCESS_TOKEN_EXPIRED_MINS * 60
  end
    
  def self.is_valid_phone(phone)
    (phone =~ /^\d{10}$/)
  end
  
  def self.md5_string(str)
    str.present? ? Digest::MD5.hexdigest(str) : str
  end
  
  def self.is_valid_number(i_no)
    (i_no =~ /^\d+$/)
  end
  
  def self.is_valid_password(password)
    self.is_ascii(password) && password.to_s.strip.length > 5  && password.to_s.strip.length < 100
  end
  
  def self.is_valid_zip(zip)
    (zip =~ /^\d{5}(-\d{4})?$/)
  end
  
  def self.is_valid_email(email)
    (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end
  
  def self.is_valid_state(state)
    state.present? && (state.upcase =~ /^[A-Z]{2}$/)
  end
  
  def self.is_valid_name(name)
    (name =~ /^[a-zA-Z\'\-_\s]+$/)
  end
  
  def self.is_valid_license(license)
    (license =~ /^[a-zA-Z0-9\-]+$/)
  end
  
  def self.is_valid_letter_number(str)
    (str =~ /^[a-zA-Z0-9\-\s]+$/)
  end
  
  def self.is_ascii(str)
    str.present? && str.ascii_only?
  end
  
  def self.is_string(str)
    str.present? && str.is_a?(String)
  end
  
  def self.encode64_str(str)
    self.is_string(str) ? Base64.strict_encode64(str.to_s.strip) : ""
  end
  
  def self.decode64_str(str)
    back_str  = ''
    begin
      back_str = Base64.strict_decode64(str) if self.is_string(str) 
    rescue ArgumentError => e
      Rails.logger.debug "Could not decrypt data: #{e}, #{str}"
    end
    back_str
  end
  
  def self.is_start_http_or_https(url)
    url.present? && url.strip.downcase.start_with?('https://', 'http://')
  end
  
  def self.is_valid_url(url)
    (url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix)
  end
  
  def self.format_datatime_to_utc(datetime)
    datetime.present? ? "#{datetime.utc.iso8601}" : ""
  end
  
  def self.str_to_boolean(str)
    str.present? && str == 'true'
  end
  
  def self.api_is_valid_images(content_type)
    content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}    
  end
  
  def self.is_number?(str)
    str =~ /\A\d+\z/ ? true : false
  end
  
end
