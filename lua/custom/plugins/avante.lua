-- AI sidebar with in-buffer diffs. Reads GEMINI_API_KEY, or ANTHROPIC_API_KEY
-- after :AvanteSwitchProvider claude, from the shell that launches Neovim. `make` compiles four Rust libraries, so cargo must be on PATH;
-- rustup was installed with --no-modify-path, hence the explicit prefix. One
-- dependency is a git URL that cargo's built-in fetcher can't authenticate.
return {
  'avante-corp/avante.nvim',
  build = 'CARGO_NET_GIT_FETCH_WITH_CLI=true PATH="$HOME/.cargo/bin:$PATH" make',
  event = 'VeryLazy',
  version = false,
  keys = {
    { '<leader>aa', '<cmd>AvanteAsk<cr>', desc = 'Avante Ask' },
    { '<leader>at', '<cmd>AvanteToggle<cr>', desc = 'Avante Toggle' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    provider = 'gemini',
    providers = {
      gemini = {
        model = 'gemini-3.6-flash',
        timeout = 30000,
      },
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-sonnet-4-5-20250929',
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
    },
    file_selector = { provider = 'telescope' },
  },
}
