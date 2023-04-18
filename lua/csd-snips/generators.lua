local MODULE = "csd-snips."

local u = require("csd-snips.utils")
local su = require("csd-snips.string_utils")

local M = {}

M.write_debug_string = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	u.write_text_to_line(ft.get_debug_string(input))
end

M.write_to_console = function()
	local ft = require(MODULE .. vim.bo.filetype)
	u.pipe({
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		u.write_line_to_buffer,
		u.move_cursor_between_paren,
	}, "")
	u.start_insert()
end

M.debug_to_console = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	local get_debug_string_without_notation =
		u.decorate_two_param_function(ft.get_debug_string, ft.without_notation)
	u.pipe({
		get_debug_string_without_notation,
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		u.write_line_to_buffer,
	}, input)
end

M.debug_string_to_console = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	local get_debug_string_with_notation = u.decorate_two_param_function(ft.get_debug_string, ft.with_notation)
	u.pipe({
		get_debug_string_with_notation,
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		u.write_line_to_buffer,
	}, input)
end

M.write_to_logger = function()
	local ft = require(MODULE .. vim.bo.filetype)
	u.pipe({
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		u.write_line_to_buffer,
		u.move_cursor_between_paren,
	}, "")
	u.start_insert()
end

M.debug_to_logger = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	local get_debug_string_without_notation =
		u.decorate_two_param_function(ft.get_debug_string, ft.without_notation)
	u.pipe({
		get_debug_string_without_notation,
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		u.write_line_to_buffer,
	}, input)
end

M.debug_string_to_logger = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	local get_debug_string_with_notation = u.decorate_two_param_function(ft.get_debug_string, ft.with_notation)
	u.pipe({
		get_debug_string_with_notation,
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		u.write_line_to_buffer,
	}, input)
end

M.debug_to_specific_logger = function(input)
	M.debug_to_logger(input)
	u.move_cursor_to_start_of_next_line()
	u.enter_select_mode_with_word_under_cursor()
end

return M
