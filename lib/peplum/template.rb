# frozen_string_literal: true

require 'peplum'

module Peplum
class Template

  require_relative "template/version"

  class Error < Peplum::Error; end

  require_relative "template/application"

end
end
