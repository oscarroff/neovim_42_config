return {
	"hardyrafael17/norminette42.nvim",
	config = function()
		local norminette = require("norminette")
		norminette.setup({
			runOnSave = false,
			maxErrorsToShow = 5,
			active = false,
		})
		-- Track state separately
		local is_active = true
		-- Add toggle method to the norminette module
		norminette.toggle = function()
			is_active = not is_active
			if is_active then
				-- Re-enable and run norminette
				norminette.setup({
					runOnSave = true,
					maxErrorsToShow = 5,
					active = true,
				})
				vim.notify("Norminette enabled", vim.log.levels.INFO)
			else
				-- Disable and clear diagnostics
				norminette.setup({
					runOnSave = false,
					maxErrorsToShow = 5,
					active = false,
				})
				vim.diagnostic.reset() -- Clear all diagnostics
				vim.notify("Norminette disabled", vim.log.levels.INFO)
			end
		end
	end,
}
