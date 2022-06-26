-- Factorial Frontend Linters:
--
---- shellcheck (by null-ls)
---- semgrep (by null-ls)
---- eslint_d (by null-ls)
---- tsserver (lsp)

local status_null, null_ls = pcall(require, "null-ls")
if not status_null then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local null_ls_sources = {}

table.insert(null_ls_sources, diagnostics.eslint_d.with({
  command = ".nvim/eslint_d",
  args = { "$FILENAME" },
}))

table.insert(null_ls_sources, diagnostics.shellcheck.with({
  command = ".nvim/shellcheck",
  args = { "$FILENAME" }
}))

table.insert(null_ls_sources, diagnostics.semgrep.with({
  command = ".nvim/semgrep",
}))

if #null_ls_sources ~= 0 then
  null_ls.setup({
    debug = true,
    sources = null_ls_sources,
    on_attach = function(client)
      if client.server_capabilities.document_formatting then
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
