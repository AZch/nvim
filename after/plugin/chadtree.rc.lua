local chadtree_settings = { 
  keymap = {
    primary = {"o", "<enter>"},
    collapse = {"h"},
    tertiary = {"<c-t>"},
    v_split = {"<c-v>"}
  },
  options = {
    close_on_open = true,
    polling_rate = 10.0
  }
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
