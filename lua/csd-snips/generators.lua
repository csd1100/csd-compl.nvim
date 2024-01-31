local MODULE = "csd-snips."

local u = require("csd-snips.utils")
local su = require("csd-snips.string_utils")

local M = {}

M.write_vars_string = function(input)
    if input and input ~= "" then
        local ft = require(MODULE .. vim.bo.filetype)
        u.write_text_to_line(ft.get_vars(input))
    else
        vim.notify("Empty or invalid input", vim.log.levels.ERROR)
    end
end

M.write_to_console = function()
    local ft = require(MODULE .. vim.bo.filetype)
    u.pipe({
        su.surround_with_parenthesis,
        ft.prepend_console_function,
        su.add_indent,
        ft.append_semicolon_if_needed,
        u.write_line_to_buffer,
        u.move_cursor_between_paren,
    }, "")
    u.start_insert()
end

M.vars_to_console = function(input)
    if input and input ~= "" then
        local ft = require(MODULE .. vim.bo.filetype)
        u.pipe({
            ft.get_vars,
            su.surround_with_parenthesis,
            ft.prepend_console_function,
            su.add_indent,
            ft.append_semicolon_if_needed,
            u.write_line_to_buffer,
        }, input)
    else
        vim.notify("Empty or invalid input", vim.log.levels.ERROR)
    end
end

M.vars_string_to_console = function(input)
    if input and input ~= "" then
        local ft = require(MODULE .. vim.bo.filetype)
        u.pipe({
            ft.get_vars_with_notation,
            su.surround_with_parenthesis,
            ft.prepend_console_function,
            su.add_indent,
            ft.append_semicolon_if_needed,
            u.write_line_to_buffer,
        }, input)
    else
        vim.notify("Empty or invalid input", vim.log.levels.ERROR)
    end
end

M.write_to_logger = function()
    local ft = require(MODULE .. vim.bo.filetype)
    u.pipe({
        su.surround_with_parenthesis,
        ft.prepend_logger_function,
        su.add_indent,
        ft.append_semicolon_if_needed,
        u.write_line_to_buffer,
        u.move_cursor_between_paren,
    }, "")
    u.start_insert()
end

M.vars_to_logger = function(input)
    if input and input ~= "" then
        local ft = require(MODULE .. vim.bo.filetype)
        u.pipe({
            ft.get_vars,
            su.surround_with_parenthesis,
            ft.prepend_logger_function,
            su.add_indent,
            ft.append_semicolon_if_needed,
            u.write_line_to_buffer,
        }, input)
    else
        vim.notify("Empty or invalid input", vim.log.levels.ERROR)
    end
end

M.vars_string_to_logger = function(input)
    if input and input ~= "" then
        local ft = require(MODULE .. vim.bo.filetype)
        u.pipe({
            ft.get_vars_with_notation,
            su.surround_with_parenthesis,
            ft.prepend_logger_function,
            su.add_indent,
            ft.append_semicolon_if_needed,
            u.write_line_to_buffer,
        }, input)
    else
        vim.notify("Empty or invalid input", vim.log.levels.ERROR)
    end
end

M.vars_to_specific_logger = function(input)
    if input and input ~= "" then
        M.vars_to_logger(input)
        u.move_cursor_to_start_of_next_line()
        u.enter_select_mode_with_word_under_cursor()
    else
        vim.notify("Empty or invalid input", vim.log.levels.ERROR)
    end
end

return M
