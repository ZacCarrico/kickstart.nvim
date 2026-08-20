-- In-buffer markdown rendering. Draws headings, tables and code blocks in the
-- buffer being edited, and shows raw markdown on whichever line the cursor is
-- on so it stays editable. Works over SSH, no browser needed.
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'markdown' },
  opts = {
    -- Show raw text on the cursor line so editing is never fighting the render.
    anti_conceal = { enabled = true },
    heading = {
      sign = false,
      width = 'block',
      left_pad = 0,
      right_pad = 2,
      icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
    },
    code = {
      sign = false,
      width = 'block',
      right_pad = 2,
    },
    -- 'full' draws box-drawing borders and pads cells to align columns.
    pipe_table = { preset = 'round' },
    bullet = { icons = { '•', '◦', '‣', '⁃' } },
    link = { enabled = true },
  },
  keys = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', desc = '[T]oggle [M]arkdown render' },
  },
}
