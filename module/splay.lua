local _M = {size = 0, root = nil}

local function new_node(k, v)
    return {key = k, value = v,left = nil, right = nil, parent = nil}
end

local function left_rotate(self, n)
    local m = n.right

    if not m then
        return
    end

    n.right = m.left

    if m.left then m.left.parent = n end

    m.parent = n.parent

    if not n.parent then
        self.root = m
    elseif n == n.parent.left then
        n.parent.left = m
    else
        n.parent.right = m
    end

    m.left = n
    n.parent = m
end

local function right_rotate(self, n)
    local m = n.left

    if not m then
        return
    end

    n.left = m.right

    if m.right then m.right.parent = n end

    m.parent = n.parent

    if not n.parent then
        self.root = m
    elseif n == n.parent.left then
        n.parent.left = m
    else
        n.parent.right = m
    end

    m.right = n
    n.parent = m
end

local function splay(self, n)

    while n.parent do
        if not n.parent.parent then
            if n.parent.left == n then
                right_rotate(self, n.parent)
            else
                left_rotate(self, n.parent)
            end
        elseif n.parent.left == n and n.parent.parent.left == n.parent then
            right_rotate(self, n.parent.parent)
            right_rotate(self, n.parent)
        elseif n.parent.right == n and n.parent.parent.right == n.parent then
            left_rotate(self, n.parent.parent)
            left_rotate(self, n.parent)
        elseif n.parent.left == n and n.parent.parent.right == n.parent then
            right_rotate(self, n.parent)
            left_rotate(self, n.parent)
        else
            left_rotate(self, n.parent)
            right_rotate(self, n.parent)
        end
    end

end

local function replace(self, n, m)

    if not n.parent then
        self.root = m
    elseif n == n.parent.left then
        n.parent.left = m
    else
        n.parent.right = m
    end

    if m then
        m.parent = n.parent
    end

end

local function subtree_min(n)
    while n.left do
        n = n.left
    end
    return n
end

local function subtree_max(n)
    while n.right do
        n = n.right
    end
    return n
end


function _M:insert(k, v)
    local p = self.root
    local q = nil

    while p do
        q = p
        if p.key < k then
            p = p.right
        else
            p = p.left
        end
    end

    p = new_node(k, v)
    p.parent = q

    if not q then
        self.root = p
    elseif q.key < p.key then
        q.right = p
    else
        q.left = p
    end

    splay(self, p)
    self.size = self.size + 1
end

function _M:find(k)
    local p = self.root
    while p do
        if p.key < k then
            p = p.right
        elseif k < p.key then
            p = p.left
        else
            val = p.value
            splay(self, p)
            return val
        end
    end

    return nil
end

function _M:remove(k)
    local p = self:find(k)
    if not p then
        return nil
    end

    splay(self, p)

    if not p.left then
        replace(self, p, p.right)
    elseif not p.right then
        replace(self, p, p.left)
    else
        local q = subtree_min(p.right)
        if q.parent ~= p then
            replace(self, q, q.right)
            q.right = p.right
            q.right.parent = q
        end
    end

    self.size = self.size - 1
end

function _M:max()
    local n = subtree_max(self.root)
    return n.key, n.value
end

function _M:min()
    local n = subtree_min(self.root)
    return n.key, n.value
end

function _M:empty()
    return self.root == nil
end

function _M:getSize()
    return self.size
end

return _M
