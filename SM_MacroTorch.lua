-- doing macro torch initialization
if not macroTorch then
    macroTorch = {}
    -- alias
    mt = macroTorch
end

if not macroTorch.context then
    macroTorch.context = {}
end

-- Slash command for macroTorch
SlashCmdList["MACROTORCH"] = function(msg)
    local info = ChatTypeInfo["SYSTEM"];
    local cmd = gsub(msg, "^%s*(%a*%.?%a*)%s*%(%s*(.-)%s*%)%s*$", "%1");
    local params = gsub(msg, "^%s*(%a*%.?%a*)%s*%(%s*(.-)%s*%)%s*$", "%2");

    -- Handle function calls like /mt catAttack()
    if cmd and cmd ~= "" then
        local funcName = cmd;

        -- Check if the function exists in macroTorch
        if type(macroTorch[funcName]) == "function" then
            -- Parse parameters if any
            local paramTable = {};
            if params and params ~= "" then
                -- Simple parameter parsing (split by comma)
                gsub(params, "[^,]+", function(arg)
                    arg = gsub(arg, "^%s*(.-)%s*$", "%1");
                    tinsert(paramTable, arg);
                end);
            end

            -- Call the function with parameters
            macroTorch[funcName](unpack(paramTable));
        else
            -- just print out the value if not function
            DEFAULT_CHAT_FRAME:AddMessage(tostring(macroTorch[funcName]), info.r, info.g, info.b, info.id);
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("MacroTorch: Usage: /mt functionName(param1, param2, ...)", info.r, info.g, info.b,
            info.id);
    end
end

-- Register slash command /mt
SLASH_MACROTORCH1 = "/mt";
SLASH_MACROTORCH2 = "/macrotorch";
