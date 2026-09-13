-- Type '@' in a markdown buffer to fuzzy-find a file and insert a markdown link to it.
return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/plugins',
  name = 'markdown-file-link',
  lazy = false,
  config = function()
    local function insert_file_link()
      pcall(function()
        require('lazy').load { plugins = { 'telescope.nvim' } }
      end)

      local origin_buf = vim.api.nvim_get_current_buf()
      local origin_win = vim.api.nvim_get_current_win()
      local origin_pos = vim.api.nvim_win_get_cursor(origin_win)

      require('telescope.builtin').find_files {
        prompt_title = 'Insert file link',
        attach_mappings = function(prompt_bufnr, map)
          local actions = require 'telescope.actions'
          local action_state = require 'telescope.actions.state'

          local function select_file()
            local entry = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if not entry then
              return
            end

            local target = entry.path or entry[1]
            local origin_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(origin_buf), ':h')
            local abs_target = vim.fn.fnamemodify(target, ':p')
            local rel_path = vim.fn.fnamemodify(abs_target, ':.')
            if origin_dir ~= '' then
              local rel_to_origin = vim.fs.relpath(origin_dir, abs_target)
              if rel_to_origin then
                rel_path = rel_to_origin
              end
            end

            local label = vim.fn.fnamemodify(target, ':t:r')
            local link = string.format('[%s](%s)', label, rel_path)

            vim.api.nvim_set_current_win(origin_win)
            vim.api.nvim_win_set_cursor(origin_win, origin_pos)
            vim.api.nvim_put({ link }, 'c', true, true)
            vim.cmd 'startinsert'
          end

          map('i', '<CR>', select_file)
          map('n', '<CR>', select_file)
          return true
        end,
      }
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(args)
        vim.keymap.set('i', '@', insert_file_link, { buffer = args.buf, desc = 'Insert markdown file link' })
      end,
    })
  end,
}
