;; extends

;; 1. 전역 변수 (최상위 선언만)
(translation_unit
  (declaration
    declarator: [
      (identifier) @name
      (array_declarator declarator: (identifier) @name)
      (pointer_declarator declarator: (identifier) @name)
    ]
    (#set! "kind" "Variable")
  ) @symbol
)

;; 2. 매크로 (#define) - 전역 성격이므로 그대로 유지
(preproc_def
  name: (identifier) @name
  (#set! "kind" "Constant")
) @symbol

(preproc_function_def
  name: (identifier) @name
  (#set! "kind" "Function")
) @symbol

;; 3. 전역 구조체, 공용체, 열거형 정의 (지역 선언 제외)
(translation_unit
  [
    ;; struct 정의
    (struct_specifier name: (type_identifier) @name (#set! "kind" "Struct"))
    ;; union 정의
    (union_specifier name: (type_identifier) @name (#set! "kind" "Struct"))
    ;; enum 정의
    (enum_specifier name: (type_identifier) @name (#set! "kind" "Enum"))
  ] @symbol
)

;; 4. 함수 정의 (이미 전역이므로 그대로 유지)
(function_definition
  declarator: (function_declarator
    declarator: (identifier) @name)
  (#set! "kind" "Function")
) @symbol
