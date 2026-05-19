--  See `:help vim.keymap.set()`

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map keys
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "qq", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", ";;", "<cmd>nohlsearch<CR>")
--vim.keymap.set("v", "§", "q")
--vim.keymap.set("n", "§", "q")
--vim.keymap.set("n", "q", "")
--vim.keymap.set("v", "q", "")
-- vim.keymap.set("v", "jk", "<Esc>")
-- vim.keymap.set("n", "jk", "<Esc>")
-- vim.keymap.set("v", "kj", "<Esc>")
-- vim.keymap.set("n", "kj", "<Esc>")

vim.keymap.set("n", "<C-t>", function()
	local manager = require("neo-tree.sources.manager")
	local state = manager.get_state("filesystem")
	local node = state.tree:get_node()

	if not node then
		vim.notify("No node selected in Neo-tree", vim.log.levels.ERROR)
		return
	end

	local path = node.path
	local is_dir = node.type == "directory"
	local dir = is_dir and path or vim.fn.fnamemodify(path, ":h")

	-- Save current window (Neo-tree), and move to next window (main buffer)
	local current_win = vim.api.nvim_get_current_win()
	vim.cmd("wincmd l") -- or "wincmd w" to go to next window
	local target_win = vim.api.nvim_get_current_win()

	if current_win == target_win then
		vim.notify("Couldn't find another window to split from", vim.log.levels.ERROR)
		return
	end

	-- Temporarily set splitright so the terminal appears to the right
	local old_splitright = vim.o.splitright
	vim.o.splitright = true
	vim.cmd("vsplit")
	vim.o.splitright = old_splitright

	vim.cmd("vertical resize 50")

	-- Change directory and open terminal
	vim.cmd("lcd " .. vim.fn.fnameescape(dir))
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { desc = "Open terminal on right from Neo-tree selection" })

-- Show manual
vim.keymap.set("n", "<Leader>m", "K", { desc = "Open terminal [m]anual page" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open [d]iagnostic quickfix [l]ist" })
vim.keymap.set("n", "<leader>dn", function()
	require("norminette").toggle()
end, { desc = "Toggle [d]iagnostic [n]orminette view" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Telescope keybindings
vim.keymap.set(
	"n",
	"<Leader>b",
	"<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>",
	{ desc = "Open telescope [b]uffers" }
)

-- In terminal mode, Alt-hjkl behave like window navigatio-- terminal: jk/kj -> go back to previous window
vim.keymap.set("t", "jk", [[<C-\><C-n><C-w>p]], { desc = "Terminal: previous window" })
vim.keymap.set("t", "kj", [[<C-\><C-n><C-w>p]], { desc = "Terminal: previous window" })
