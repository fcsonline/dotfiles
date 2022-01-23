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
