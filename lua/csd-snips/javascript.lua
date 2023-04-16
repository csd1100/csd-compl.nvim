local COMMA = ","
local WHITESPACE = " "
local CONSOLE_LOG = "console.log"
local LOGGER_DEBUG = "logger.debug"

-- TODO: refactor
local function get_var(var)
	return var .. ": " .. "${" .. var .. "}"
end

-- TODO: refactor
local function get_var_with_notation(var)
	return var .. ": " .. "${JSON.stringify(" .. var .. ")}"
end

-- TODO: refactor
local function get_vars_string(vars_table, var_string_generator)
	local line = ""
	for i, var in ipairs(vars_table) do
		local var_string = var_string_generator(var)
		line = line .. var_string
		if i < #vars_table then
			line = line .. COMMA .. WHITESPACE
		end
	end
	return line
end

local string_utils = require("csd-snips.string_utils")

local M = {}

-- TODO: refactor
M.get_debug_string = function(string_input)
	local vars_table = string_utils.split_string(string_input, COMMA)
	return string_utils.surround_with_back_ticks(get_vars_string(vars_table, get_var))
end

-- TODO: refactor
M.get_debug_string_with_notation = function(string_input)
	local vars_table = string_utils.split_string(string_input, COMMA)
	return string_utils.surround_with_back_ticks(get_vars_string(vars_table, get_var_with_notation))
end

M.prepend_console_function = function(string_input)
	return CONSOLE_LOG .. string_input
end

M.prepend_logger_function = function(string_input)
	return LOGGER_DEBUG .. string_input
end

return M
