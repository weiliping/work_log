class Errors::Api::Error < StandardError
  attr_reader :code
  attr_reader :title
  attr_reader :status
  attr_reader :meta

  CODES = [
    :invalid_destination_token,
    :recurly_api_error,
  ]

  def initialize(msg = nil, **options)
    if options[:code] && !CODES.include?(options[:code])
      raise "Invalid error code \"#{options[:code]}\""
    end

    super(msg)
    @message = msg
    @code = options[:code]
    @title = options[:title]
    @status = options[:status]
    @meta = options[:meta] || {}
  end
end