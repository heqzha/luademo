local stree = require 'module.splay'
local checker = require'module.checker'
local posix = require 'posix'
local i = 0
local max = 100000


print("Insert Begin:"..posix.gettimeofday().usec)
for i = 1, max do
    local data = "a"..i
    stree:insert(checker.crc32(0, data), data)
end
print("Insert end:"..posix.gettimeofday().usec)

print("Size: "..stree:getSize())
local k,v = stree:max()
print("Max: k-"..k.." v-"..v)
k,v = stree:min()
print("Min: k-"..k.." v-"..v)

local data = "a"..max
print("Begin:"..posix.gettimeofday().usec)
local v = stree:find(checker.crc32(0, data))
print("End:"..posix.gettimeofday().usec)
if v then
    print("find"..v)
end


for i = 0, max do
    stree:remove(i)
end
print("Done")
