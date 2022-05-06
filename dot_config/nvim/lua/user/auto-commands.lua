-- Remove trailing spaces
vim.cmd [[
  autocmd BufWritePre * %s/\s\+$//e
]]

-- Check file modifications in the background
vim.cmd [[
  autocmd BufEnter,FocusGained,CursorMoved,FocusLost,WinLeave * :lua vim.api.nvim_command('checktime')
]]

-- Restores the cursor in last position
vim.cmd [[
  au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
]]

-- Commit messages spell
vim.cmd [[
  augroup git_commits
    autocmd!
    autocmd FileType gitcommit setlocal spell spelllang=en_us
  augroup end
]]

-- Markdown configuration
vim.cmd [[
  augroup markdown
    autocmd!
    autocmd FileType markdown setlocal textwidth=79
    autocmd FileType markdown setlocal spell spelllang=en_us
    autocmd FileType markdown setlocal noshiftround
  augroup end
]]

-- Ruby configuration
vim.cmd [[
  augroup ruby
    autocmd!

    autocmd FileType ruby nnoremap <leader>n :TestNearest<cr>
    autocmd FileType ruby nnoremap <leader>f :TestFile<cr>
    autocmd FileType ruby nnoremap <leader>r :Dispatch bundle exec rubocop --safe-auto-correct %<cr>
  augroup end
]]

-- Rust configuration
vim.cmd [[
  augroup rust
    autocmd!

    autocmd FileType rust nnoremap <leader>n :TestNearest<cr>
    autocmd FileType rust nnoremap <leader>f :TestFile<cr>
    autocmd BufWritePre *.rs silent execute "!cargo fmt"
  augroup end
]]
