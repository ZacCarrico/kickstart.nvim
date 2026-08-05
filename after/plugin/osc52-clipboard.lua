-- OSC 52 clipboard: yanks in nvim travel through SSH/tmux to the host
-- terminal's clipboard (e.g. iTerm2), so Cmd+V works in other panes.
-- Requires `set -g set-clipboard on` in tmux.
-- Guarded so local-only sessions keep using the native pasteboard.
if vim.env.SSH_CONNECTION or vim.env.TMUX then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end
