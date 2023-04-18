local COMMA = ","

local M = {}

M.get_indent = function(lineNumber)
	return vim.fn.indent(lineNumber)
end

M.add_indent = function(line, lineNumber)
	local currentLineNumber = vim.api.nvim_win_get_cursor(0)[1]
	local indent = M.get_indent(currentLineNumber)
	local newLine = line
	for _ = 1, indent, 1 do
		newLine = " " .. newLine
	end
	return newLine
end

M.prepend = function (str, prepend_with)
    return prepend_with .. str
end

M.append = function (str, append_with)
    return str .. append_with
end

M.surround_string = function(str, start_surround, end_surround)
	return start_surround .. str .. end_surround
end

M.split_string = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

M.surround_with_parenthesis = function(string)
	return "(" .. string .. ")"
end

M.surround_with_curly_brace = function(string)
	return "{" .. string .. "}"
end

M.surround_with_square_brackets = function(string)
	return "[" .. string .. "]"
end

M.surround_with_back_ticks = function(string)
	return "`" .. string .. "`"
end

M.surround_with_double_quotes = function(string)
	return '"' .. string .. '"'
end

M.surround_with_single_quotes = function(string)
	return "'" .. string .. "'"
end

M.split_string_by_comma = function (inputstr)
    return M.split_string(inputstr, COMMA)
end

return M
