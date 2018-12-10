class ApplicationController < ActionController::API
  rescue_from Exception do |exception|
    Rails.logger.info(exception.class.name)
    Rails.logger.info(exception.message)
    Rails.logger.info(exception.error)
    Rails.logger.info(exception.backtrace.join("\n\r"))
    render status: exception.status, json: exception.error
  end
end
