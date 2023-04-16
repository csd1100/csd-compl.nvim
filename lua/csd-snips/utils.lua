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

local change_cursor_location = function(current, row_increase, column_increase)
	local cursor_position = M.shallow_copy(current)
	cursor_position[1] = cursor_position[1] + row_increase
	cursor_position[2] = cursor_position[2] + column_increase
	return cursor_position
end

M.move_cursor_between_paren = function(str)
	local paren_position = string.find(str, "%(")
	local new_cursor_position = change_cursor_location(vim.api.nvim_win_get_cursor(0), 1, paren_position + 1)
	move_cursor(new_cursor_position)
end

M.reducer_pipe = function(functions, runner, accumulator)
	local new_accumulator = accumulator
	for _, to_run in ipairs(functions) do
		new_accumulator = runner(to_run, new_accumulator)
	end
	return new_accumulator
end

M.runner = function(to_run, input)
	return to_run(input)
end

return M
