vim.g.user = "thblack-"
vim.g.mail = "thblack-@student.hive.fi"

return {
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = {
			{
				"<F1>",
				function()
					vim.cmd("Stdheader")
				end,
				desc = "Insert/update 42 header",
			},
		},
		opts = {
			default_map = true,
			auto_update = true,
			user = vim.g.user,
			mail = vim.g.mail,
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},
	{
		"Diogo-ss/42-C-Formatter.nvim",
		cmd = "CFormat42",
		keys = {
			{ "<leader>cf", ":CFormat42 ", desc = "[C][f]ormatter for 42 norm" },
		},
		config = function()
			local formatter = require("42-formatter")
			formatter.setup({
				formatter = "c_formatter_42",
				filetypes = { c = true, h = true, cpp = true, hpp = true },
			})
		end,
	},
	{
		"hardyrafael17/norminette42.nvim",
		config = function()
			local norminette = require("norminette")
			norminette.setup({
				runOnSave = false,
				maxErrorsToShow = 5,
				active = false,
			})
			local is_active = true
			norminette.toggle = function()
				is_active = not is_active
				if is_active then
					norminette.setup({
						runOnSave = true,
						maxErrorsToShow = 5,
						active = true,
					})
					vim.notify("Norminette enabled", vim.log.levels.INFO)
				else
					norminette.setup({
						runOnSave = false,
						maxErrorsToShow = 5,
						active = false,
					})
					vim.diagnostic.reset()
					vim.notify("Norminette disabled", vim.log.levels.INFO)
				end
			end
		end,
	},
}
