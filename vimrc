" ******************************* "
"                                 "
"            :::      ::::::::    "
"          :+:      :+:    :+:    "
"        +:+ +:+         +:+      "
"      +#+  +:+       +#+         "
"    +#+#+#+#+#+   +#+            "
"         #+#    #+#              "
"        ###   ########.fr        "
"                                 "
" ******************************* "

"Better command completion
set wildmenu
set wildmode=list:longest

"Show current line
set cursorline

"Syntax coloration
syntax on
colorscheme desert

"highlight search
set hlsearch

"replace space with tab
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
""use :'<,'>SuperRetab 2

"tab size
:set tabstop=4

:let mapleader = "-"


" c++ canonical class template generator

:function Set_class_hpp()
:	let	l:name = expand('%:f')
:	let l:newname = toupper(l:name)
:	let l:newname = substitute(l:newname, "\\.", "_", "g")
:	let l:newname = substitute(l:newname, "\\n", "", "g")

:	exe ":normal! A" . "#ifndef " . l:newname . "\n"
:	exe ":normal! A" . "# define " . l:newname . "\n\n"

:	let l:cmd = "echo \"" . l:name . "\" | cut -d \".\" -f1"
:	let	l:name = system(l:cmd)

:	exe ":normal A" . "#include <iostream>\n\n"
:	exe ":normal! A" . "class " . l:name . "{\n\<ESC>i\tpublic:\n\n"

:	let l:name = substitute(l:name, "\n", "", "")
:	exe ":normal A" . "\t\t" . l:name . "( void );\n"
:	exe ":normal! A" . "\t\t" . l:name . "( " . l:name . " const & src );\n"
:	exe ":normal A" . "\t\t~" . l:name . "( void );\n\n"
:	exe ":normal A" . "\t\t" . l:name . " &\toperator=( " . l:name . " const & rhs" . " );"
:	exe ":normal A" . "\n\nprivate:\n\n\n};\n\n"
:	exe ":normal! A" . "#endif //!" . l:newname . "\n"
:	exe ":normal A" . "\<ESC>gg"
:	echo "[default pattern set]"
:endfunction

:function Set_class_cpp()
:	let	l:name = expand('%:f')
:	exe ":normal A" . "#include <iostream>\n"

:	let l:cmd = "echo \"" . l:name . "\" | cut -d \".\" -f1"
:	let	l:name = system(l:cmd)
:	let l:name = substitute(l:name, "\n", "", "")
:	let l:namehpp = l:name . ".hpp"

:	exe ":normal A" . "#include \"" . l:namehpp . "\"\n\n\n"
:	exe ":normal A" . l:name . "::" . l:name . "( void )\n{\n\n"
:	exe ":normal! A" . "\treturn ;\n}\n\n"
:	exe ":normal A" . l:name . "::" . l:name . "( " . l:name . " const & src )"
:	exe ":normal! A" . "\n{\n\n\<ESC>i\treturn ;\n\<ESC>i}\n\n"
:	exe ":normal A" . l:name . "::~" . l:name . "( void )\n{\n\n"
:	exe ":normal! A" . "\treturn ;\n}\n\n"
:	exe ":normal A" . l:name . " &\t" . l:name . "::operator=( " . l:name
:	exe ":normal A" . " const & rhs )\n{\n\<ESC>i\treturn *this; // allow a = b = c\n}"
:	exe ":normal A" . "\<ESC>gg"
:	echo "[default pattern set]"
:endfunction

"Uncomment to creat the cannonical template each time you open a new file .class.hpp/.class.cpp
":autocmd BufNewFile *.class.hpp :call Set_class_hpp()
":autocmd BufNewFile *.class.cpp :call Set_class_cpp()


"link functions to commands ([ESC]-cpp/[ESC]-hpp)
:nnoremap <leader>cpp :call Set_class_cpp()
:nnoremap <leader>hpp :call Set_class_hpp()

" end
