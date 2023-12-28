local configs = require("gentags.configs")

local M = {}

-- A tool module has these APIs: load/init/update/terminate
--
--- @alias gentags.Tool {load:fun():nil,init:fun():nil,update:fun():nil,terminate:fun():nil}
--- @type table<string, gentags.Tool>
local TOOLS_MAP = {
  ctags = require("gentags.ctags"),
}

--- @return gentags.Tool
local function get_toolchain()
  local tool = configs.get().tool
  local toolchain = TOOLS_MAP[string.lower(tool)] --[[@as gentags.Tool]]
  assert(
    toolchain ~= nil,
    string.format("%s is not supported!", vim.inspect(tool))
  )
  return toolchain
end

M.load = function()
  get_toolchain().load()
end

M.init = function()
  ---@diagnostic disable-next-line: undefined-field
  get_toolchain().init()
end

M.update = function()
  ---@diagnostic disable-next-line: undefined-field
  get_toolchain().update()
end

M.terminate = function()
  ---@diagnostic disable-next-line: undefined-field
  get_toolchain().terminate()
end

return M
