vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/webhooked/kanso.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("^2") },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/shellRaining/hlchunk.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
	{ src = "https://github.com/echasnovski/mini.files" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/barrett-ruth/live-server.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})
require("kanso").setup({ minimal = false, italics = false })

require("mason").setup({})

require("guess-indent").setup({})

pcall(function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"typescript",
			"javascript",
			"query",
			"vim",
			"vimdoc",
		},
		auto_install = true,
		highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
		indent = { enable = true, disable = { "ruby" } },
	})
end)
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})

require("blink.cmp").setup({
	fuzzy = { implementation = "lua" },
	signature = { enabled = true },
	keymap = { preset = "default" },
	appearance = { nerd_font_variant = "mono" },
	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	snippets = { preset = "luasnip" },
})

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable = { c = true, cpp = true }
		if disable[vim.bo[bufnr].filetype] then
			return nil
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		cpp = { "clang_format" },
		javascript = { "prettierd", stop_after_first = true },
		typescript = { "prettierd", stop_after_first = true },
		html = { "prettierd", stop_after_first = true },
		css = { "prettierd", stop_after_first = true },
	},
})

local lint = require("lint")
lint.linters_by_ft = {
	markdown = { "markdownlint" },
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
	callback = function()
		if vim.bo.modifiable then
			lint.try_lint()
		end
	end,
})

local telescope = require("telescope")
telescope.setup({
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

require("which-key").setup({
	delay = 0,
	icons = {
		mappings = vim.g.have_nerd_font,
		keys = vim.g.have_nerd_font and {} or {
			Up = "<Up> ",
			Down = "<Down> ",
			Left = "<Left> ",
			Right = "<Right> ",
			C = "<C-…> ",
			M = "<M-…> ",
			D = "<D-…> ",
			S = "<S-…> ",
			CR = "<CR> ",
			Esc = "<Esc> ",
			NL = "<NL> ",
			BS = "<BS> ",
			Space = "<Space> ",
			Tab = "<Tab> ",
		},
	},
	spec = {
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		{ "<leader>T", group = "[T]erminal" },
		{ "<leader>f", desc = "[F]ormat buffer" },
		{ "<leader>e", desc = "Open mini.files (cwd)" },
		{ "<leader>E", desc = "Open mini.files (current file)" },
		{ "<leader>b", desc = "Debug: Toggle Breakpoint" },
		{ "<leader>B", desc = "Debug: Set Breakpoint" },
		{ "<leader>q", desc = "Open diagnostic [Q]uickfix list" },
		{ "<leader>ps", desc = "[P]lugin [S]ync/update" },
	},
})

require("hlchunk").setup({
	chunk = { enable = true },
	line_num = { enable = true },
})

require("todo-comments").setup({ signs = false })
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local map = function(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, { desc = "Jump to next git [c]hange" })
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git [c]hange" })

		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [s]tage hunk" })
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "git [r]eset hunk" })

		map("n", "<leader>hs", gs.stage_hunk, { desc = "git [s]tage hunk" })
		map("n", "<leader>hr", gs.reset_hunk, { desc = "git [r]eset hunk" })
		map("n", "<leader>hS", gs.stage_buffer, { desc = "git [S]tage buffer" })
		map("n", "<leader>hu", gs.stage_hunk, { desc = "git [u]ndo stage hunk" })
		map("n", "<leader>hR", gs.reset_buffer, { desc = "git [R]eset buffer" })
		map("n", "<leader>hp", gs.preview_hunk, { desc = "git [p]review hunk" })
		map("n", "<leader>hb", gs.blame_line, { desc = "git [b]lame line" })
		map("n", "<leader>hd", gs.diffthis, { desc = "git [d]iff against index" })
		map("n", "<leader>hD", function()
			gs.diffthis("@")
		end, { desc = "git [D]iff against last commit" })
		map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
		map("n", "<leader>tD", gs.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })
	end,
})
require("mini.files").setup({
	mappings = {
		close = "q",
		go_in = "l",
		go_in_plus = "L",
		go_out = "h",
		go_out_plus = "H",
		mark_goto = "'",
		mark_set = "m",
		reset = "<BS>",
		reveal_cwd = "@",
		show_help = "g?",
		synchronize = "=",
		trim_left = "<",
		trim_right = ">",
	},
	options = {
		permanent_delete = true,
		use_as_default_explorer = true,
	},
	windows = {
		max_number = math.huge,
		preview = false,
		width_focus = 50,
		width_nofocus = 15,
		width_preview = 25,
	},
})

require("toggleterm").setup({
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
})

local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup({
	automatic_installation = true,
	handlers = {},
	ensure_installed = { "delve" },
})

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
	controls = {
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
			disconnect = "⏏",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

require("dap-go").setup({
	delve = { detached = vim.fn.has("win32") == 0 },
})
