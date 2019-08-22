# frozen_string_literal: true

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
  puts 'no awesome_print :('
end

# Pry.config.correct_indent = false
# Pry.config.auto_indent = false

begin
  if defined?(PryDebugger) || defined?(PryByebug)
    Pry.commands.alias_command 'c', 'continue'
    Pry.commands.alias_command 's', 'step'
    Pry.commands.alias_command 'n', 'next'
    Pry.commands.alias_command 'f', 'finish'
    Pry.commands.alias_command 'wai', 'whereami'
    Pry.commands.alias_command 'dp', 'disable-pry'
  end
rescue LoadError => e
  puts e
end

Pry::Commands.command /^$/, 'repeat last command' do
  _pry_.run_command Pry.history.to_a.last
end