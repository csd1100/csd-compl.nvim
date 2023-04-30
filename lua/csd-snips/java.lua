local string_utils = require("csd-snips.string_utils")
local utils = require("csd-snips.utils")

local CONSOLE_LOG = "System.out.println"
local MESSAGE_FORMAT = "MessageFormat.format"
local LOGGER_DEBUG = "logger.debug"
local TO_STRING = ".toString()"

local closure_message_format = function()
    local counter = 0
    return function(var, append_to)
        local var_string = var .. ": " .. "{" .. counter .. "}"
        counter = counter + 1
        return append_to .. string_utils.surround_string(var_string, "[", "]")
    end
end

local append_comma_and_var = function(var, append_to)
    return append_to .. "," .. var
end

local append_comma_and_var_notation = function(var, append_to)
    return append_to .. "," .. var .. TO_STRING
end

local closure_param_list = function(vars_table, params_generator)
    return function(append_to)
        return utils.reducer(vars_table, params_generator, append_to)
    end
end

local M = {}

M.get_debug = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)

    local get_var_string = closure_message_format()
    local append_param_list =
        closure_param_list(vars_table, append_comma_and_var)
    local generate_message_format = utils.decorate_three_param_function(
        utils.reducer,
        vars_table,
        get_var_string
    )

    return utils.pipe({
        generate_message_format,
        string_utils.surround_with_double_quotes,
        append_param_list,
        string_utils.surround_with_parenthesis,
        M.prepend_message_format,
    }, "")
end

M.get_debug_with_notation = function(string_input)
    local vars_table = string_utils.split_string_by_semicolon(string_input)

    local get_var_string = closure_message_format()
    local append_param_list =
        closure_param_list(vars_table, append_comma_and_var_notation)
    local generate_message_format = utils.decorate_three_param_function(
        utils.reducer,
        vars_table,
        get_var_string
    )

    return utils.pipe({
        generate_message_format,
        string_utils.surround_with_double_quotes,
        append_param_list,
        string_utils.surround_with_parenthesis,
        M.prepend_message_format,
    }, "")
end

M.prepend_console_function = function(string_input)
    return CONSOLE_LOG .. string_input
end

M.prepend_message_format = function(string_input)
    return MESSAGE_FORMAT .. string_input
end

M.prepend_logger_function = function(string_input)
    return LOGGER_DEBUG .. string_input
end

return M
