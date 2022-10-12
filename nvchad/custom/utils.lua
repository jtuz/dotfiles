local M = {}

M.OSX = function()
  return vim.loop.os_uname().sysname == "Darwin"
end

M.LINUX = function()
  return vim.loop.os_uname().sysname == "Linux"
end

return M
