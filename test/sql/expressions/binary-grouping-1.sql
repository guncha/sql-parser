SELECT * FROM t where -1 * (2 + 3)
; SELECT * FROM t where 3 + 4 * 5 > 20
; SELECT * FROM t where v1 = ((v2 * 5) - v3)
; SELECT (j.data->>j.field::text)::integer FROM json_data j
; SELECT labels && ARRAY[?] FROM products