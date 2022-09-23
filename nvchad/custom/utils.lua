local M = {}

M.getos = function()
  fh, err = io.popen("uname -s 2>/dev/null", "r")
  if fh then
    osname = fh:read()
  end

  if osname then return osname end

  return "unknown"
end

M.osx_platform = function()
  return M.getos() == "Darwin"
end

M.linux_platform = function()
  return M.getos() == "Linux"
end

return M
