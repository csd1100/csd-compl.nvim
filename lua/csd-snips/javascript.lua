local string_utils = require("csd-snips.string_utils")
local utils = require("csd-snips.utils")

local SEMICOLON = ";"
local CONSOLE_LOG = "console.log"
local LOGGER_DEBUG = "logger.debug"

local M = {}

M.without_notation = function(var, append_to)
	local var_string = var .. ": " .. "${" .. var .. "}"
	return append_to .. string_utils.surround_string(var_string, "[", "]")
end
M.with_notation = function(var, append_to)
	local var_string = var .. ": " .. "${JSON.stringify(" .. var .. ")}"
	return append_to .. string_utils.surround_string(var_string, "[", "]")
end

M.get_debug_string = function(string_input, var_string_generator)
	local vars_table = string_utils.split_string(string_input, SEMICOLON)
	local line = utils.reducer(vars_table, var_string_generator, "")
	return string_utils.surround_with_back_ticks(line)
end

M.prepend_console_function = function(string_input)
	return CONSOLE_LOG .. string_input
end

M.prepend_logger_function = function(string_input)
	return LOGGER_DEBUG .. string_input
end

return M
