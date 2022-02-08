-- Initialize null-ls linters and formatters
local status_null, null_ls = pcall(require, "null-ls")
if not status_null then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local null_ls_sources = {}

local exists_local_file = function (local_path)
  return vim.fn.filereadable(vim.fn.getcwd() .. '/' .. local_path) == 1
end

-- Rubocop doesn't have command_resolver like eslint, so we have to do this to
-- take in account the bash configuration to run rubocop
if exists_local_file('.rubocop.yml') and exists_local_file('Gemfile') then
  table.insert(null_ls_sources, formatting.rubocop.with({
    command = 'bash',
    args = { '-c', 'rubocop --auto-correct -f quiet --stderr --stdin $FILENAME' }
  }))
  table.insert(null_ls_sources, diagnostics.rubocop.with({
    command = 'bash',
    args = { '-c', 'rubocop -f json $FILENAME' }
  }))
end

table.insert(null_ls_sources, formatting.eslint_d)
table.insert(null_ls_sources, diagnostics.eslint_d)
table.insert(null_ls_sources, formatting.rustywind) -- Tailwind organizer
table.insert(null_ls_sources, diagnostics.shellcheck)
table.insert(null_ls_sources, completion.spell.with({ filetypes = { "markdown" } }))

if #null_ls_sources ~= 0 then
  null_ls.setup({
    debug = true,
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

