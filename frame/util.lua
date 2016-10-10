printt = function (t)
  print('{')
  for k, v in ipairs(t) do
    if type(v) == 'table' then
      print('  '..k..' = {...}')
    else
      print('  '..k..' = '..v)
    end
  end
  print('}')
end

-- 浅复制
scopy = function (dst, src)
  if not src then
    src = dst
    dst = {}
  end

  for k, v in pairs(src) do
    dst[k] = v
  end

  return dst
end