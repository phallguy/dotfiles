return {
  {
    "mbbill/undotree",
    config = function ()
      vim.keymap.set("n", "<leader>fu", "<CMD>UndotreeShow<CR><CMD>UndotreeFocus<CR>")
    end
  }
}
