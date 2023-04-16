local MODULE = "csd-snips."

local utils = require("csd-snips.utils")
local su = require("csd-snips.string_utils")

local M = {}

M.write_debug_string = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.write_text_to_line(ft.get_debug_string(input))
end

M.write_to_console = function()
	local ft = require(MODULE .. vim.bo.filetype)
	utils.pipe({
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		utils.write_line_to_buffer,
		utils.move_cursor_between_paren,
	}, "")
	utils.start_insert()
end

M.debug_to_console = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.pipe({
		ft.get_debug_string,
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		utils.write_line_to_buffer,
	}, input)
end

-- TODO: refactor
M.debug_string_to_console = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.pipe({
		ft.get_debug_string_with_notation,
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		utils.write_line_to_buffer,
	}, input)
end

M.write_to_logger = function()
	local ft = require(MODULE .. vim.bo.filetype)
	utils.pipe({
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		utils.write_line_to_buffer,
		utils.move_cursor_between_paren,
	}, "")
	utils.start_insert()
end

M.debug_to_logger = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.pipe({
		ft.get_debug_string,
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		utils.write_line_to_buffer,
	}, input)
end

-- TODO: refactor
M.debug_string_to_logger = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.pipe({
		ft.get_debug_string_with_notation,
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		utils.write_line_to_buffer,
	}, input)
end

M.debug_to_specific_logger = function(input)
	M.debug_to_logger(input)
	utils.move_cursor_to_start_of_next_line()
	utils.enter_select_mode_with_word_under_cursor()
end

return M
