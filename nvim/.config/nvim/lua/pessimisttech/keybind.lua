local map = {}

local function bind(mode, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", 
        outer_opts, 
        opts or {}
        )
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

map.nmap = bind("n", {noremap = false})
map.nnoremap = bind("n")
map.vnoremap = bind("v")
map.inoremap = bind("i")

return map
