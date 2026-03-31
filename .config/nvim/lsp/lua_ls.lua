return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			completion = { callSnippet = "Replace" },
			diagnostics = {
				enable = true,
				globals = { "vim" },
			},
			workspace = {
				-- Makes the server aware of Neovim runtime files (replaces lazydev.nvim)
				library = { vim.env.VIMRUNTIME },
				checkThirdParty = false,
			},
		},
	},
}
