# -*- encoding : utf-8 -*-
require 'active_support/core_ext/module/aliasing'

module ActiveResource
  module ConnectionWithDetailedLogSubscriber
    attr_reader :response

    def request(method, path, *arguments)
      result = super(method, path, *arguments)
      detailed_log_subscriber(result, arguments)
      result
    rescue => e
      detailed_log_subscriber(e.response, arguments) if e.respond_to?(:response)
      raise
    end

    def detailed_log_subscriber(response, arguments)
      ActiveSupport::Notifications.instrument("request.active_resource_detailed") do |payload|
        payload[:response] = response
        payload[:data]     = arguments
      end
    end
  end
  class Connection
    prepend ConnectionWithDetailedLogSubscriber
  end

end
