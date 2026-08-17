return {
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_commands = true,
			lazy_load = false,
			options = {
				tailwind = "both",
			},
		},
	},
	{
		"MaximilianLloyd/tw-values.nvim",
		keys = {
			{ "<leader>sv", "<cmd>TWValues<cr>", desc = "Show Tailwind [v]alues" },
		},
		opts = {
			border = "rounded",
			show_unknown_classes = true,
		},
	},
}
