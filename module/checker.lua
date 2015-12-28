local ffi           = require "ffi"
local C             = ffi.C

local _M = {}

ffi.cdef[[
uint32_t crc32(uint32_t crc, const void *buf, size_t size);
]]

local crc32lib = ffi.load('crc32.so')

function _M.crc32(crc, data)
    local new_crc = crc32lib.crc32(crc, data, #data)
    return new_crc
end


return _M
