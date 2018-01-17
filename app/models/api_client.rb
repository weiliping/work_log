class ApiClient < ApplicationRecord
  require 'securerandom'
  attr_accessible :name, :app_token, :app_secret, :id, :is_active, :created_at, :updated_at, :enable_cors
  
  before_create :generate_app_secret
  scope :active, -> { where('"api_clients".is_active = ?', true) }
  
  after_create :create_api_key_for_client
  
  def self.get_default_api_key
    ApiClient.active.order('id asc').first     
  end
  
  def generate_app_secret
    begin
      self.app_token = SecureRandom.urlsafe_base64(16)
    end while self.class.exists?(app_token: app_token)
    begin
      self.app_secret = SecureRandom.hex
    end while self.class.exists?(app_secret: app_secret)
  end
  
  def create_api_key_for_client
    api_key = ApiKey.new
    api_key.api_client_id = self.id
    api_key.save
  end
  
  def basic_auth
    if self.app_token.present?
      UsersHelper.md5_string(self.app_token+":"+self.app_secret)
    else
      ""
    end
  end
end
