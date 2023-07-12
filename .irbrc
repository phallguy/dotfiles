# frozen_string_literal: true

IRB.conf[:USE_AUTOCOMPLETE] = false
IRB.conf[:SHOW_FRAMES] = 0
IRB.conf[:SHOW_SRC_LINES] = 25
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_MULTILINE] = true

ARGV.concat [
  "--readline",
  "--prompt-mode",
  "simple",
]

### START debundle.rb ###

# MIT License
# Copyright (c) Conrad Irwin <conrad.irwin@gmail.com>
# Copyright (c) Jan Lelis <mail@janlelis.de>
# https://github.com/janlelis/debundle.rb/blob/master/debundle.rb

module Debundle
  VERSION = '1.1.0'

  def self.debundle!
    return unless defined?(Bundler)
    return unless Gem.post_reset_hooks.reject! do |hook|
      hook.source_location.first =~ %r{/bundler/}
    end

    ENV.replace(Bundler::EnvironmentPreserver.new(ENV, %w[GEM_PATH]).backup) if defined? Bundler::EnvironmentPreserver
    Gem.clear_paths

    load 'rubygems/core_ext/kernel_require.rb'
    load 'rubygems/core_ext/kernel_gem.rb'
  rescue StandardError
    warn 'DEBUNDLE.RB FAILED'
    raise
  end
end

### END debundle.rb ###


def enhance!
  Debundle.debundle!

  [
    'irb/completion',
    'irbtools/binding',
    'irbtools/more',
    'looksee',
    'hirb',
    'bond',
  ].each do |gem|
    require gem
  rescue LoadError => e
    puts e
  end
end

begin
  require 'rails/console/app'
  extend Rails::ConsoleMethods
rescue LoadError
end

begin
  require 'active_support/testing/time_helpers'
  include ActiveSupport::Testing::TimeHelpers
rescue LoadError
end
