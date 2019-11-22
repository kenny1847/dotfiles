" Vim syntax file
" Language: ya.make file
" Maintainer: Mikhail Borisov <borman@yandex-team.ru>

if exists("b:current_syntax")
	finish
endif

syn case match

syn iskeyword A-Z,_,48-57

syn region yamakeComment start="#" end="$"

syn match yamakeDirSlash /\// contained
syn match yamakeToken /[^#()[:space:]]\+/ contained contains=yamakeDirSlash,yamakeVar
syn region yamakeString start=/"/ end=/"/ contained oneline
syn match yamakeVarName /\${[^}]\+}/ms=s+2,me=e-1 contained
syn region yamakeVar start=/\${/ end=/}/ contained oneline contains=yamakeVarName
syn match yamakeKeyword /[A-Z][A-Z_]*[[:space:])]\@=/ contained

syn match yamakeCondVar /[A-Z][A-Z_]*[[:space:])]\@=/ contained
syn keyword yamakeCondOperator AND OR NOT EQUAL STREQUAL MATCHES GREATER LESS DEFINED

syn cluster yamakeArg contains=yamakeComment,yamakeVar,yamakeString,yamakeKeyword,yamakeToken
syn cluster yamakeCondArg contains=yamakeCondVar,yamakeCondOperator,yamakeString

syn region yamakeArguments start=/(/ end=/)/ contains=@yamakeArg fold
syn region yamakeCondArguments start=/(/ end=/)/ contains=@yamakeCondArg

syn keyword yamakeProject skipwhite nextgroup=yamakeArguments
            \ PROGRAM PY_PROGRAM PY3_PROGRAM JAVA_PROGRAM GO_PROGRAM TOOL
            \ LIBRARY PY_LIBRARY PY23_LIBRARY JAVA_LIBRARY GO_LIBRARY PROTO_LIBRARY FAT_OBJECT
            \ DLL PYMODULE
            \ UNITTEST UNITTEST_FOR PYTEST PYTEST_SCRIPT EXECTEST JTEST JTEST_FOR
            \ BENCHMARK FUZZ
            \ PACKAGE UNION TGZ_PACKAGE PT_PACKAGE
            \ UDF UDF_LIB YQL_UDF YQL_PYTHON_UDF
            \ SANDBOX_TASK
            \ RECURSE END
syn keyword yamakeConditional skipwhite nextgroup=yamakeCondArguments
            \ IF ELSE ELSEIF ENDIF
syn keyword yamakeInclude skipwhite nextgroup=yamakeArguments
            \ INCLUDE
syn keyword yamakeProperty skipwhite nextgroup=yamakeArguments
            \ OWNER
            \ SIZE TIMEOUT FORK_SUBTESTS SPLIT_FACTOR REQUIREMENTS
syn match yamakeCommand /[A-Z][A-Z_]*/ skipwhite nextgroup=yamakeArguments

syn sync fromstart

hi def link yamakeComment Comment
hi def link yamakeCommand Statement
hi def link yamakeEscaped Special
hi def link yamakeKeyword Tag
hi def link yamakeVarName Identifier
hi def link yamakeVar Delimiter
hi def link yamakeCondVar Identifier
hi def link yamakeDirSlash Comment
hi def link yamakeToken Normal
hi def link yamakeString String
hi def link yamakeProject Type
hi def link yamakeConditional Conditional
hi def link yamakeInclude Include
hi def link yamakeProperty Define
hi def link yamakeCondOperator Conditional
hi def link yamakeArguments Delimiter
hi def link yamakeCondArguments Delimiter

let b:current_syntax = "yamake"
