--~/.brew/bin/lua

local colors = require "color"
local error = 0

if not arg[1] then
        error = -1
        f = io.popen("norminette")
        print(f:read("*a"))
end

for k,v in ipairs(arg) do
    --print(k, v)
    local f = io.popen("norminette ".. v)
    l = f:read("*l")
    while l do
        if l:sub(0,5) == "Error" then
            print(colors('%{red}'..l))
            error = error + 1
        elseif l:sub(0,7) == "Warning" then
            print(colors('%{bright red}'..l))
            error = error + 1
        else
            print(colors('%{bright blue}'..l))
        end
        l = f:read("*l")
    end
    f:close()
end

os.exit(error)
