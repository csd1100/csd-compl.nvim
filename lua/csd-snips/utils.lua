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

M.write_line_to_buffer = function(line, lineNumber)
	vim.api.nvim_buf_set_lines(0, lineNumber, lineNumber, false, line)
end

M.write_text_to_line = function(line, cursorPosition)
	vim.api.nvim_buf_set_text(
		0,
		cursorPosition[1] - 1, -- current row
		cursorPosition[2] + 1, -- next column
		cursorPosition[1] - 1,
		cursorPosition[2] + 1,
		line
	)
end

M.reducer_pipe = function(functions, runner, accumulator)
	local newAccumulator = accumulator
	for _, toRun in ipairs(functions) do
		newAccumulator = runner(toRun, newAccumulator)
	end
	return newAccumulator
end

M.runner = function(toRun, input)
	return toRun(input)
end

return M
