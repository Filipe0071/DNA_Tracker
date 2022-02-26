function string.tohex(s, chunkSize)
    s = (type(s) == "string" and s or type(s) == "nil" and "" or tostring(s))
    chunkSize = chunkSize or 2048

    local rt = {}
    string.tohex_sformat =
        (string.tohex_sformat and string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and
        string.tohex_sformat) or
        string.rep("%02X", math.min(#s, chunkSize))
    string.tohex_chunkSize =
    
    (string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_chunkSize or chunkSize)
    for i = 1, #s, chunkSize do
        rt[#rt + 1] =
            string.format(
            string.tohex_sformat:sub(1, (math.min(#s - i + 1, chunkSize) * 4)),
            s:byte(i, i + chunkSize - 1)
        )
    end
    if #rt == 1 then
        return rt[1]
    else
        return table.concat(rt, "")
    end
end
