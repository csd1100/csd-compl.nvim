local MODULE = "csd-snips."

local utils = require("csd-snips.utils")
local su = require("csd-snips.string_utils")

local function write_debug(function_sequence, input)
	local out = utils.reducer_pipe(function_sequence, utils.runner, input)
	local currentLineNumber = vim.api.nvim_win_get_cursor(0)[1]
	utils.write_to_buffer({ out }, currentLineNumber)
end

local M = {}

M.debug_to_console = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
    write_debug({
		ft.get_debug_line,
		su.surround_with_parenthesis,
		ft.prepend_console_function,
		su.add_indent,
	}, input)
end

M.debug_to_logger = function(input)
	local ft = require(MODULE .. vim.bo.filetype)
    write_debug({
		ft.get_debug_line,
		su.surround_with_parenthesis,
		ft.prepend_logger_function,
		su.add_indent,
	}, input)
end

return M
