# frozen_string_literal: true

require_relative "lib/peplum/template/version"

Gem::Specification.new do |spec|
  spec.name = "peplum-template"
  spec.version = Peplum::Template::VERSION
  spec.authors = ["Tasos Laskos"]
  spec.email = ["tasos.laskos@ecsypno.com"]

  spec.summary = "Peplum template project."
  spec.description = "Peplum template project."
  spec.homepage = "http://ecsypno.com/"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files  = Dir.glob( 'bin/*')
  spec.files += Dir.glob( 'lib/**/*')
  spec.files += Dir.glob( 'examples/**/*')
  spec.files += %w(peplum-template.gemspec)


  spec.add_dependency "peplum"
end
