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