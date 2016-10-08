class ApplicationJob < ActiveJob::Base
  def logger
    Sidekiq.logger
  end
end
