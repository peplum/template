# frozen_string_literal: true

require 'peplum'

module Peplum
class Template

  require_relative "template/version"
  require_relative "template/native"

  class Error < Peplum::Error; end

  class Application < Peplum::Application
    def native_app
      Native
    end
  end

end
end
