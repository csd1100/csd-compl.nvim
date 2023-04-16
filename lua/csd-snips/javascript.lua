local COMMA = ","
local WHITESPACE = " "
local CONSOLE_LOG = "console.log"
local LOGGER_DEBUG = "logger.debug"

local function get_var(var)
	return var .. ": " .. "${" .. var .. "}"
end

local function get_vars(vars_table)
	local line = ""
	for i, var in ipairs(vars_table) do
		local var_string = get_var(var)
		line = line .. var_string
		if i < #vars_table then
			line = line .. COMMA .. WHITESPACE
		end
	end
	return line
end

local string_utils = require("csd-snips.string_utils")

local M = {}

M.get_debug_string = function(string_input)
	local vars_table = string_utils.split_string(string_input, COMMA)
	return string_utils.surround_with_back_ticks(get_vars(vars_table))
end

M.prepend_console_function = function(string_input)
	return CONSOLE_LOG .. string_input
end

M.prepend_logger_function = function(string_input)
	return LOGGER_DEBUG .. string_input
end

return M
