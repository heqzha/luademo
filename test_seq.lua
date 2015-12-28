local posix = require 'posix'

local i = 0
local max = 100000

local array = {}
print("Insert Begin:"..posix.gettimeofday().usec)

for i = 1, max do
    local data = "a"..i
    table.insert(array, data)
end
print("Insert end:"..posix.gettimeofday().usec)

local data = "a"..max

print("Begin:"..posix.gettimeofday().usec)

for i,v in ipairs(array) do
    if data == v then
        --print("find"..v)
        break
    end
end
print("End:"..posix.gettimeofday().usec)

print("Done")
