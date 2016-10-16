" CreateVar Plugin
" Author: Erik Gregg
" github.com/hank/vim-createcvar

function! NewVarAtTopOfFunction()
    " Save position
    let l:stash = getpos('.')
    " Increment the line count because we'll add a line
    let l:stash[1] = l:stash[1] + 1
    call inputsave()
    let l:vartype = input('Enter var type: ')
    let l:varname = input('Enter var name: ')
    let l:varval  = input('Enter var value: ')
    call inputrestore()
    " Jump to top of function
    normal! [[
    " Append the new declaration
    call append('.', l:vartype . ' ' . l:varname . ' = ' . l:varval . ';')
    " Move down, indent line, set cursor to end
    normal! j==
    redraw
    " Set mark 'v' to the variable declaration
    call setpos("'v", getpos('.'))
    " Sleep 1.5 seconds to allow breakout for edit
    sleep 1500m
    " Go back to original position
    call setpos('.', l:stash)
endfunction

"" Moves a variable declared on the current line to the
"" top of the function.  Modifies the current line such
"" that it does not re-define the variable.
function! MoveVarToTopOfFunction()
    " Save position
    let l:stash = getpos('.')
    " Increment the line count because we'll add a line
    let l:stash[1] = l:stash[1] + 1
    " Grab the declaration from the current line using regexp
    let l:varmatch = matchlist(getline('.'), '\v^\s*([A-Za-z0-9*&_]+%(\s*\*)?)\s*([A-Za-z0-9_]+)\s*\=')
    try
        let l:vartype = l:varmatch[1]
        let l:varname = l:varmatch[2]
    catch
        echo 'Line is not formatted correctly for this command'
        return
    endtry
    " Jump to top of function
    normal! [[
    " Ask the user for the value
    call inputsave()
    let l:varval  = input(l:vartype . ' ' . l:varname . ' = ')
    call inputrestore()
    " Append the new declaration
    call append('.', l:vartype . ' ' . l:varname . ' = ' . l:varval . ';')
    " Move down, indent line
    normal! j==
    redraw
    " Set mark 'v' to the variable declaration
    call setpos("'v", getpos('.'))
    " Sleep 1.5 seconds to allow breakout for edit
    sleep 1500m
    " Go back to original position
    call setpos('.', l:stash)
    " Get rid of the type part so we're just left with the assignment
    let l:vartype = substitute(l:vartype, '*', '\\*', '')
    execute 's/' . l:vartype . '\s*//'
endfunction
