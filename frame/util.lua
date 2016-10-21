printt = function (t)
  print('{')
  for k, v in pairs(t) do
    if type(v) == 'table' then
      print('  '..k..' = {...}')
    else
      print('  '..k..' = '..tostring(v))
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

-- 正负号
math.sign = function (num)
  if num > 0 then
    return 1
  elseif num < 0 then
    return -1
  else
    return 0
  end
end