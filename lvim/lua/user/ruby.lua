vim.g["ruby_indent_access_modifier_style"] = "indent"
vim.g["splitjoin_ruby_curly_braces "] = 0
vim.g["splitjoin_ruby_hanging_args"] = 0
vim.g["splitjoin_ruby_trailing_comma"] = 1
vim.g["splitjoin_normalize_whitespace"] = 1
vim.g["splitjoin_align"] = 1
vim.g["splitjoin_ruby_options_as_arguments"] = 1

vim.g["test#ruby#use_spring_binstub"] = 0

-- let g:rails_projections = {
--   \  "app/controllers/*_controller.rb": {
--   \      "test": [
--   \        "test/controllers/{}_controller_test.rb",
--   \        "spec/requests/{}_controller_spec.rb",
--   \        "spec/controllers/{}_controller_spec.rb"
--   \      ],
--   \      "alternate": [
--   \        "test/controllers/{}_controller_test.rb",
--   \        "spec/requests/{}_controller_spec.rb",
--   \        "spec/controllers/{}_controller_spec.rb"
--   \      ],
--   \   },
--   \   "spec/requests/*_spec.rb": {
--   \      "command": "request",
--   \      "alternate": "app/controllers/{}.rb",
--   \      "template": "require 'rails_helper'\n\n" .
--   \        "RSpec.describe '{}' do\nend",
--   \   },
--   \ }
