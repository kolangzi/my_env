; extends

;; ============================================================================
;; Custom aerial.nvim query extensions for C++ (also applies to .h files)
;; - Adds macros (#define), global variables, and typedefs
;; - The default cpp aerial query already handles: struct, enum, class,
;;   function_declarator (definitions + prototypes)
;; - Uses #not-has-ancestor? to exclude local declarations (inside functions)
;; ============================================================================
;; 1. Global variables (excludes function-local and parameter declarations)

;;    - Simple declaration: int x;
((declaration
  declarator: (identifier) @name @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Array: int arr[];
((declaration
  declarator: (array_declarator
    declarator: (identifier) @name) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Pointer: char *p;
((declaration
  declarator: (pointer_declarator
    declarator: (identifier) @name) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Pointer + Array: const char *const arr[];
((declaration
  declarator: (pointer_declarator
    declarator: (array_declarator
      declarator: (identifier) @name)) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Initialized: int x = 0;
((declaration
  declarator: (init_declarator
    declarator: (identifier) @name) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Initialized array: int arr[] = {0};
((declaration
  declarator: (init_declarator
    declarator: (array_declarator
      declarator: (identifier) @name)) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Initialized pointer: char *p = NULL;
((declaration
  declarator: (init_declarator
    declarator: (pointer_declarator
      declarator: (identifier) @name)) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;;    - Initialized pointer + array: const char *const usage[] = {...};
((declaration
  declarator: (init_declarator
    declarator: (pointer_declarator
      declarator: (array_declarator
        declarator: (identifier) @name))) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#not-has-ancestor? @symbol parameter_list)
  (#set! "kind" "Variable")
))

;; 2. Macros (#define)
(preproc_def
  name: (identifier) @name
  (#set! "kind" "Constant")
) @symbol

(preproc_function_def
  name: (identifier) @name
  (#set! "kind" "Function")
) @symbol

;; 3. Typedef (struct/enum typedef + function pointer typedef)
((type_definition
  declarator: (type_identifier) @name) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#set! "kind" "TypeParameter")
)

((type_definition
  declarator: (function_declarator
    declarator: (type_identifier) @name)) @symbol
  (#not-has-ancestor? @symbol compound_statement)
  (#set! "kind" "TypeParameter")
)
