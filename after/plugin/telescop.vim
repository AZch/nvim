if !exists('g:loaded_telescope') | finish | endif

nnoremap  <silent> <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap  <silent> <space>rg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap  <silent> <C-f> <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <silent> <C-b> <cmd>Telescope buffers<cr>
" nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF
