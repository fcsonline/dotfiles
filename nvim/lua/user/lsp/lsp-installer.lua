local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  local lang_ok, lang_opts = pcall(require, "user.lsp.settings." .. server.name)
  if lang_ok then
    opts = vim.tbl_deep_extend("force", lang_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

-- install automatically all this lsp on start
local installable_servers = {}

if vim.fn.executable("node") == 1 then
  table.insert(installable_servers, 'bashls')
  table.insert(installable_servers, 'cssls')
  table.insert(installable_servers, 'bashls')
  table.insert(installable_servers, 'html')
  table.insert(installable_servers, 'jsonls')
  table.insert(installable_servers, 'yamlls')
  table.insert(installable_servers, 'tailwindcss')
  table.insert(installable_servers, 'tsserver')
end

if vim.fn.executable("ruby") == 1 then
  table.insert(installable_servers, 'sorbet')
  table.insert(installable_servers, 'solargraph')
end

if vim.fn.executable("rustc") == 1 then
  table.insert(installable_servers, 'rust_analyzer')
end

for _, name in pairs(installable_servers) do
  local found, server = lsp_installer.get_server(name)
  if found then
    if not server:is_installed() then
      print("installing: " .. name)
      server:install()
    end
  end
end

-- Initialize null-ls linters and formatters
local status_null, null_ls = pcall(require, "null-ls")
if not status_null then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local null_ls_sources = {}

-- formatting
table.insert(null_ls_sources, formatting.rubocop)
table.insert(null_ls_sources, formatting.eslint)
table.insert(null_ls_sources, formatting.rustywind) -- Tailwind organizer

-- diagnostics
table.insert(null_ls_sources, diagnostics.rubocop)
table.insert(null_ls_sources, diagnostics.eslint)
table.insert(null_ls_sources, diagnostics.shellcheck)

-- completion
table.insert(null_ls_sources, completion.spell.with({ filetypes = { "markdown" } }))

if #null_ls_sources ~= 0 then
  null_ls.setup({
    debug = false,
    sources = null_ls_sources,
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
          augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2500)
          augroup END
         ]])
      end
    end,
  })
end
