local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/Users/antonzhuikov/workspace/' .. project_name
require('jdtls').start_or_attach({
  cmd = {
    'java', -- or '/path/to/java11_or_newer/bin/java'
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
        '-javaagent:/Users/antonzhuikov/.local/jars/lombok.jar',
        '-Xbootclasspath/a:/Users/antonzhuikov/.local/jars/lombok.jar',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/Users/antonzhuikov/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/Users/antonzhuikov/.local/share/nvim/lsp_servers/jdtls/config_mac',
    '-data', workspace_dir
  },

   root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml'}),

   settings = {
     java = {
     }
   },
   on_attach = on_attach,
   init_options = {
     bundles = {}
   },
 })
