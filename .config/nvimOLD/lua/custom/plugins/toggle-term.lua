return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    cmd = { 'ToggleTerm' },
    keys = {
      {
        '<leader>Tf',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, 0, vim.loop.cwd(), 'float')
        end,
        desc = 'ToggleTerm (float cwd)',
      },
      {
        '<leader>Th',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, 15, vim.loop.cwd(), 'horizontal')
        end,
        desc = 'ToggleTerm (horizontal cwd)',
      },
      {
        '<leader>Tv',
        function()
          local count = vim.v.count1
          require('toggleterm').toggle(count, vim.o.columns * 0.4, vim.loop.cwd(), 'vertical')
        end,
        desc = 'ToggleTerm (vertical cwd)',
      },
      {
        '<leader>Tn',
        '<cmd>ToggleTermSetName<cr>',
        desc = 'Set term name',
      },
      {
        '<leader>Ts',
        '<cmd>TermSelect<cr>',
        desc = 'Select term',
      },
      {
        '<leader>Tt',
        function()
          require('toggleterm').toggle(1, 100, vim.loop.cwd(), 'tab')
        end,
        desc = 'ToggleTerm (tab cwd)',
      },
      {
        '<leader>TT',
        function()
          require('toggleterm').toggle(1, 100, vim.loop.cwd(), 'tab')
        end,
        desc = 'ToggleTerm (tab cwd)',
      },
    },
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
    },
  },
}
