# frozen_string_literal: true

require 'peplum'

module Peplum
class Template

class Application < Peplum::Application
  require_relative "application/native"
  require_relative 'application/services/my_service'

  # TODO: Adjust accordingly.
  provision_memory 100 * 1024 * 1024

  # TODO: Adjust accordingly.
  provision_disk   100 * 1024 * 1024

  # TODO: Is a service necessary?
  instance_service_for :my_service, Services::MyService

  def native_app
    Native
  end

end

end
end
