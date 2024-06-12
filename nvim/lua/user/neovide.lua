if vim.g.neovide then
  -- Allow clipboard copy paste in neovim
  vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

  vim.g.neovide_transparency = 0.95
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_show_border = false
  vim.g.experimental_layer_grouping = true
  vim.g.neovide_input_macos_option_key_is_meta = 'both'

  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
