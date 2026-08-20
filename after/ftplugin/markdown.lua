-- Prose settings for markdown. The 100-column hard wrap matches the writing
-- style used across these notes, so `gq` and auto-wrap produce the same shape
-- the files are already in.
vim.opt_local.textwidth = 100
vim.opt_local.colorcolumn = '101'
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Move by screen line rather than file line, so a wrapped paragraph navigates
-- the way it looks.
vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { buffer = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { buffer = true })
