if !exists('g:lspconfig')
  finish
endif

lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See :help vim.lsp.* for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.ls.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
 if client.name == 'tsserver' then
   client.resolved_capabilities.document_formatting = false
 end

end


-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)


nvim_lsp.gopls.setup {
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.jdtls.setup{
  on_attach = on_attach,
  cmd = { 'jdtls' },
}

nvim_lsp.tsserver.setup {
  on_attach  = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'non-relative'
    }
  },
  capabilities = capabilities
}

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
}


nvim_lsp.bashls.setup{
    on_attach = on_attach,
    -- cmd = { "/home/ss/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh" };
    cmd = { "bash-language-server", "start" }
}



local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
 


-- Linter/Prettier setup
 local dlsconfig = require 'diagnosticls-configs'

 local eslint = require 'diagnosticls-configs.linters.eslint'
 eslint = vim.tbl_extend('force', eslint, {
   debounce = 1000
})

 local eslint_d = require 'diagnosticls-configs.linters.eslint_d'
 eslint_d = vim.tbl_extend('force', eslint, {
   debounce = 1000
})
 local prettier = require 'diagnosticls-configs.formatters.prettier'

 dlsconfig.init {
   -- Your custom attach function
   on_attach = on_attach,
 }
 dlsconfig.setup {
   ['javascript'] = {
     linter = { eslint_d },
     formatter = prettier
   },
   ['javascriptreact'] = {
     -- Add multiple linters
     linter = { eslint_d },
     -- Add multiple formatters
     formatter = prettier
   },
   ['typescript'] = {
     linter = { eslint_d },
     formatter = prettier
   },
   ['typescriptreact'] = {
     -- Add multiple linters
     linter = { eslint_d },
     -- Add multiple formatters
     formatter = prettier
   }
 }

EOF
