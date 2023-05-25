# frozen_string_literal: true

require 'peplum'

module Peplum
class Template

class Application < Peplum::Application
  require_relative "application/payload"
  require_relative 'application/services/my_service'

  # TODO: Adjust accordingly.
  provision_memory 100 * 1024 * 1024

  # TODO: Adjust accordingly.
  provision_disk   100 * 1024 * 1024

  # TODO: Is a service necessary?
  instance_service_for :my_service, Services::MyService

  # TODO: Is this service necessary?
  #
  # Theres already `Template::Application.shared_hash` but if you need more you can add them here.
  instance_service_for :my_hash, Peplum::Application::Services::SharedHash

  # @return [#run, #split, #merge]
  #
  #   * `#run` -- Worker; executes its payload against `objects`.
  #   * `#split` -- Scheduler; splits given `objects` into groups for each worker.
  #   * `#merge` -- Scheduler; merges results from multiple workers.
  #
  #   That's all we need to turn any application into a super version of itself.
  def payload
    Payload
  end

end

end
end
