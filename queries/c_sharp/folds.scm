[
  (for_statement)
  (while_statement)
  (class_declaration)
  (record_declaration)
  (method_declaration)
  (do_statement)
  (switch_statement)
  (using_statement)+
  (if_statement)
  (try_statement)
  (catch_clause)
  (invocation_expression)
  (initializer_expression)
  (using_directive)+
  (preproc_region)
  (comment)
  (preproc_if)
  (preproc_elif)
] @fold

(preproc_region (preproc_endregion) @fold)
