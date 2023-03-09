lvim.builtin.lualine.options.globalstatus = false
lvim.builtin.lualine.winbar = {}

lvim.builtin.lualine.sections = {
  lualine_a = { 'mode' },
  lualine_b = {},
  lualine_c = { { 'filename', path = 1 } },
  lualine_x = { 'filetype' },
  lualine_y = {  },
  lualine_z = { {
    'diagnostics',
    sources = { 'ale', 'nvim_diagnostic' },
    colored = false
  } }
}

lvim.builtin.lualine.inactive_sections = {
  lualine_a = { '' },
  lualine_b = {},
  lualine_c = { { 'filename', path = 1 } },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

lvim.builtin.lualine.options.component_separators = { left = '', right = '' }
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }

require('bqf').setup({
  auto_enable = true,
  auto_resize_height = true,
  preview = {
    win_height = 15,
    win_vheight = 15,
    delay_syntax = 80,
    show_title = false
  }
})