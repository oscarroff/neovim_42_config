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
	vim.cmd("wincmd l")
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

-- terminal: jk/kj -> go back to previous window
vim.keymap.set("t", "jk", [[<C-\><C-n><C-w>p]], { desc = "Terminal: previous window" })
vim.keymap.set("t", "kj", [[<C-\><C-n><C-w>p]], { desc = "Terminal: previous window" })

-- Open URL under cursor with system browser
vim.keymap.set("n", "gx", function()
	local url = vim.fn.expand("<cfile>")
	if url:match("^https?://") then
		local open_cmd
		if vim.fn.has("macunix") == 1 then
			open_cmd = "open"
		elseif vim.fn.has("unix") == 1 then
			open_cmd = "xdg-open"
		elseif vim.fn.has("win32") == 1 then
			open_cmd = "start"
		end
		if open_cmd then
			vim.fn.jobstart({ open_cmd, url }, { detach = true })
			print("Opening: " .. url)
		else
			print("No suitable open command found for your system.")
		end
	else
		print("Not a valid URL: " .. url)
	end
end, { desc = "Open URL under cursor with system handler" })

-- Terminal toggle (bottom split)
local term_bufnr = nil

local function term_bottom_toggle(height)
	height = height or 8

	if term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr) then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == term_bufnr then
				vim.api.nvim_set_current_win(win)
				vim.cmd("startinsert")
				return
			end
		end
		vim.cmd(("botright %dsplit"):format(height))
		vim.api.nvim_win_set_buf(0, term_bufnr)
		vim.cmd("startinsert")
		return
	end

	vim.cmd(("botright %dsplit"):format(height))
	vim.cmd("terminal")
	term_bufnr = vim.api.nvim_get_current_buf()
	vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>z", function()
	term_bottom_toggle(8)
end, { desc = "Terminal (toggle, bottom split)" })

-- Filetype extensions
vim.filetype.add({
	extension = {
		tpp = "cpp",
	},
})
