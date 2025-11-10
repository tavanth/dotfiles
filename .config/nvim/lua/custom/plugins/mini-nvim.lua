return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()

    -- Setup mini.files
    require('mini.files').setup {
      -- Customization of shown content
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },
      -- Module mappings created only inside explorer.
      mappings = {
        close = 'q',
        go_in = 'l',
        go_in_plus = 'L',
        go_out = 'h',
        go_out_plus = 'H',
        mark_goto = "'",
        mark_set = 'm',
        reset = '<BS>',
        reveal_cwd = '@',
        show_help = 'g?',
        synchronize = '=',
        trim_left = '<',
        trim_right = '>',
      },
      -- General options
      options = {
        permanent_delete = true,
        use_as_default_explorer = true,
      },
      -- Customization of explorer windows
      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
      },
    }

    -- Keymaps for mini.files
    vim.keymap.set('n', '<leader>e', function()
      require('mini.files').open(vim.api.nvim_buf_get_name(0))
    end, { desc = 'Open mini.files (current file)' })

    vim.keymap.set('n', '<leader>E', function()
      require('mini.files').open()
    end, { desc = 'Open mini.files (cwd)' })

    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    vim.cmd [[
hi StatusLine guibg=NONE ctermbg=NONE
hi StatusLineNC guibg=NONE ctermbg=NONE]]

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        -- Set base statusline transparent
        vim.cmd [[
  hi StatusLine guibg=NONE ctermbg=NONE
  hi StatusLineNC guibg=NONE ctermbg=NONE
  ]]
        -- Set mini statusline sections transparent
        vim.api.nvim_set_hl(0, 'MiniStatuslineDevinfo', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'MiniStatuslineFileinfo', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = 'NONE' })
      end,
    })
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
