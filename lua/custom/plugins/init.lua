-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.g.user = "thblack-"
vim.g.mail = "thblack-@student.hive.fi"
return {
	{
		"epheien/termdbg",
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		require("custom.plugins.header42"),
	},
	{
		require("custom.plugins.cformat42"),
	},
	{
		require("custom.plugins.inc-rename"),
	},
	{
		require("custom.plugins.csvview"),
	},
	{
		require("custom.plugins.norminette42"),
	},
}
