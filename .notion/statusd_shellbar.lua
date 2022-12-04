function get_shell(cmd)
    local handle = io.popen(cmd, 'r')
    if not handle then
        return "could not open shellbar.sh"
    end
    local result, error = handle:read('*a')
    handle:close()
    if not result then
        return "(" .. error .. ")" -- chance of interrupted system call
    end
    return result
end

local timer = statusd.create_timer()

local function update()
    statusd.inform("shellbar", get_shell('/home/sdk/.notion/shellbar.sh'))
    timer:set(5000, update)
end

update()
