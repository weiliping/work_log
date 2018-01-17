class ApiKey < ApplicationRecord
  include Api::ApiHelper
  require 'securerandom'
  attr_accessible :user_id, :access_token, :id, :is_active, :created_at, :updated_at, :api_client_id, :expires_at
  
  belongs_to :user
  belongs_to :api_client
  
  scope :active, -> { where('"api_keys".is_active = ?', true) }
  before_create :generate_token
  before_create :set_expires_at
  
  def self.get_default_api_key
    # ApiKey.where('name = ?', 'default').first  
    ApiKey.where('is_active = ?', true).order("id asc").first  
  end
  
  def generate_token
    begin
      # SecureRandom.urlsafe_base64(16) 
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
  
  def set_expires_at
    self.expires_at = Api::ApiHelper.access_token_expired 
  end
end
