class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::ParamsParser::ParseError => e
      if env['HTTP_ACCEPT'] =~ /application\/json/
        error_output = "Unable to parse json"
        return [
            400, { :'Content-Type' => "application/json" },
            [{errors: [
                code: "bad_request",
                status: "400",
                title: "Bad request",
                detail: error_output,
                meta: {}
            ]}.as_json]
        ]
      else
        Rails.logger.debug("Raising")
        raise e
      end
    end
  end
end