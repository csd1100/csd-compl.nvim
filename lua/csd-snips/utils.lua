local string_utils = require("csd-snips.string_utils")
local M = {}

M.shallow_copy = function(t)
	local t2 = {}
	for k, v in pairs(t) do
		t2[k] = v
	end
	return t2
end

M.get_input = function(prompt, callback)
	vim.ui.input({
		prompt = prompt,
	}, callback)
end

M.start_insert = function()
	vim.cmd.startinsert()
end

M.start_visual = function()
	vim.api.nvim_feedkeys("v", "n", true)
end

M.enter_select_mode_with_word_under_cursor = function()
	vim.api.nvim_input("ve<C-g>")
end

M.write_line_to_buffer = function(line)
	local line_number = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, line_number, line_number, false, { line })
	return line
end

M.write_text_to_line = function(line)
	local cursor_position = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_text(
		0,
		cursor_position[1] - 1, -- current row
		cursor_position[2] + 1, -- next column
		cursor_position[1] - 1,
		cursor_position[2] + 1,
		{ line }
	)
	return line
end

local move_cursor = function(cursor_position)
	vim.api.nvim_win_set_cursor(0, cursor_position)
end

M.move_cursor_between_paren = function(str)
	local paren_position = string.find(str, "%(")
	local new_cursor_position = { vim.api.nvim_win_get_cursor(0)[1] + 1, paren_position }
	print(vim.inspect(new_cursor_position))
	move_cursor(new_cursor_position)
end

M.move_cursor_to_start_of_next_line = function()
	local current_cursor_position = vim.api.nvim_win_get_cursor(0)
	local indent_column = string_utils.get_indent(current_cursor_position[1])
	local new_cursor_position = {
		current_cursor_position[1] + 1,
		indent_column,
	}
	move_cursor(new_cursor_position)
end

M.reducer = function(list, runner, accumulator)
	local new_accumulator = accumulator
	for _, element in ipairs(list) do
		new_accumulator = runner(element, new_accumulator)
	end
	return new_accumulator
end

M.runner = function(to_run, input)
	return to_run(input)
end

M.pipe = function(functions, accumulator)
	return M.reducer(functions, M.runner, accumulator)
end

M.decorate_two_param_function = function(fn, prefilledParam)
	local inner = function(actualParam)
		local output = fn(actualParam, prefilledParam)
		return output
	end
	return inner
end

M.decorate_three_param_function = function(fn, prefilledParam1, prefilledParam2)
	local inner = function(actualParam)
		local output = fn(prefilledParam1, prefilledParam2, actualParam)
		return output
	end
	return inner
end

return M
