local utils = require("csd-snips.utils")
local generators = require("csd-snips.generators")

local VAR_PROMPT = "Enter semicolon separated vars to print: "

local check_filetype = function(callback)
    local status, _ = pcall(require, "csd-snips." .. vim.bo.filetype)
    if not status or vim.bo.filetype == "" then
        vim.notify(
            "The file type " .. vim.bo.filetype .. " is not supported",
            vim.log.levels.ERROR
        )
    else
        callback()
    end
end

local M = {}

M.enabled = false

-- TODO: setup function
M.setup = function(config)
    vim.notify("Not Yet Implemented")
    -- TODO: logger level config
    -- TODO: mapping config
end

M.write_vars_string = function()
    check_filetype(function()
        utils.get_input(VAR_PROMPT, generators.write_vars_string)
    end)
end

M.write_to_console = function()
    check_filetype(function()
        generators.write_to_console()
    end)
end

M.write_to_logger = function()
    check_filetype(function()
        generators.write_to_logger()
    end)
end

M.vars_to_console = function()
    check_filetype(function()
        utils.get_input(VAR_PROMPT, generators.vars_to_console)
    end)
end

M.vars_to_logger = function()
    check_filetype(function()
        utils.get_input(VAR_PROMPT, generators.vars_to_logger)
    end)
end

M.vars_string_to_console = function()
    check_filetype(function()
        utils.get_input(VAR_PROMPT, generators.vars_string_to_console)
    end)
end

M.vars_string_to_logger = function()
    check_filetype(function()
        utils.get_input(VAR_PROMPT, generators.vars_string_to_logger)
    end)
end

M.vars_to_specific_logger = function()
    check_filetype(function()
        utils.get_input(VAR_PROMPT, generators.vars_to_specific_logger)
    end)
end

return M
