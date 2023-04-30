local string_utils = require("csd-snips.string_utils")
local utils = require("csd-snips.utils")

local CONSOLE_LOG = "console.log"
local LOGGER_DEBUG = "logger.debug"

local get_vars = function(var, append_to)
    local var_string = var .. ": " .. "${" .. var .. "}"
    return append_to .. string_utils.surround_string(var_string, "[", "]")
end

local get_vars_with_notation = function(var, append_to)
    local var_string = var .. ": " .. "${JSON.stringify(" .. var .. ")}"
    return append_to .. string_utils.surround_string(var_string, "[", "]")
end

local M = {}

M.get_debug = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)
    local line = utils.reducer(vars_table, get_vars, "")
    return string_utils.surround_with_back_ticks(line)
end

M.get_debug_with_notation = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)
    local line = utils.reducer(vars_table, get_vars_with_notation, "")
    return string_utils.surround_with_back_ticks(line)
end

M.prepend_console_function = function(string_input)
    return CONSOLE_LOG .. string_input
end

M.prepend_logger_function = function(string_input)
    return LOGGER_DEBUG .. string_input
end

return M
