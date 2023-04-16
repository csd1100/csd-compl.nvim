local utils = require("csd-snips.utils")
local generators = require("csd-snips.generators")

local VAR_PROMPT = "Enter comma separated vars to print: "

local M = {}

M.enabled = false

-- TODO: setup function
M.setup = function(config)
	vim.notify("Not Yet Implemented")
	-- TODO: logger level config
	-- TODO: mapping config
end

M.write_debug_string = function()
	utils.get_input(VAR_PROMPT, generators.write_debug_string)
end

M.write_to_console = function()
	generators.write_to_console()
end

M.write_to_logger = function()
	generators.write_to_logger()
end

M.debug_to_console = function()
	utils.get_input(VAR_PROMPT, generators.debug_to_console)
end

M.debug_to_logger = function()
	utils.get_input(VAR_PROMPT, generators.debug_to_logger)
end

M.debug_string_to_console = function()
	-- TODO: console log string representation
	vim.notify("Not Yet Implemented")
end

M.debug_string_to_logger = function()
	-- TODO: logger string representation
	vim.notify("Not Yet Implemented")
end

M.debug_to_specific_logger = function()
	utils.get_input(VAR_PROMPT, generators.debug_to_specific_logger)
end

return M
