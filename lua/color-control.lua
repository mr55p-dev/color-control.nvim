local M = {}
local path = require("plenary.path")
local schemeFile = path:new(vim.fn.stdpath("data"), "color-control", "color")
local lvl = vim.log.levels

--- Save a colorscheme to the data file
---@param color string
function M.saveColorScheme(color)
	if schemeFile:touch({ parents = true }) == false then
		vim.notify("Failed to create data dir/file", lvl.ERROR)
		return
	end
	if schemeFile:write(color, "w", 310) == false then
		vim.notify("Failed to create data file", lvl.ERROR)
		return
	end
end

--- Load a colorscheme from the data file
function M.loadColorScheme()
	local lines = schemeFile:readlines()
	if #lines == 0 then
		vim.notify("No saved colorscheme", lvl.INFO)
		return
	end
	M.setColorscheme(lines[1])
end

--- Set the UI colorscheme
---@param scheme string
function M.setColorscheme(scheme)
	vim.cmd("colorscheme " .. scheme)
end

function M.setup()
	vim.notify("Entered color control!", lvl.INFO)
	M.loadColorScheme()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function(ev)
			M.saveColorScheme(ev.match)
		end,
	})
	vim.api.nvim_create_user_command("ColorControl", function(cmd)
		M.saveColorScheme(cmd.args)
		M.setColorscheme(cmd.args)
	end, { nargs = 1 })
end

return M
