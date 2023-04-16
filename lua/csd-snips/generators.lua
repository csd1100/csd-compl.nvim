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
	utils.reducer_pipe({
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		utils.write_line_to_buffer,
		utils.move_cursor_between_paren,
		utils.start_insert,
	}, utils.runner, "")
end

M.debug_to_console = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.reducer_pipe({
		ft.get_debug_string,
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
		utils.write_line_to_buffer,
	}, utils.runner, input)
end

M.write_to_logger = function()
	local ft = require(MODULE .. vim.bo.filetype)
	utils.reducer_pipe({
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		utils.write_line_to_buffer,
		utils.move_cursor_between_paren,
		utils.start_insert,
	}, utils.runner, "")
end

M.debug_to_logger = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
	utils.reducer_pipe({
		ft.get_debug_string,
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
		utils.write_line_to_buffer,
	}, utils.runner, input)
end

return M
