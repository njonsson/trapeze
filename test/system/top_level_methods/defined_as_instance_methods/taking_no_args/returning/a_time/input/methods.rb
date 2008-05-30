def foo
  # Because the truth test files were created in Central Standard Time.
  cst_offset = Time.now.utc_offset + 18000
  Time.local(2001, 1, 1, 1, 1, 1, 1) + cst_offset
end

def bar
  # Because the truth test files were created in Central Standard Time.
  cst_offset = Time.now.utc_offset + 18000
  Time.local(2002, 2, 2, 2, 2, 2, 2) + cst_offset
end
