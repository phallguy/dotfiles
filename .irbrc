# frozen_string_literal: true

IRB.conf[:USE_AUTOCOMPLETE] = true
IRB.conf[:SHOW_FRAMES] = 0
IRB.conf[:SHOW_SRC_LINES] = 30
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_MULTILINE] = true

ARGV.concat [
  '--noreadline',
  '--prompt-mode',
  'simple'
]

# begin
#   require 'rails/console/app'
#   extend Rails::ConsoleMethods
# rescue LoadError
# end
#
# begin
#   require 'active_support/testing/time_helpers'
#   include ActiveSupport::Testing::TimeHelpers
# rescue LoadError
# end

begin
  require_relative File.join(Dir.pwd, '.irb_local')
rescue LoadError
end
