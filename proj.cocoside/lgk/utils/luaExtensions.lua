function requiresafe(module)
    local function requiref(module)
        return require(module)
    end
    res, module = pcall(requiref,module)
    if not res then
        return nil
     else
        return module
     end
end