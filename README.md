CreateCVar
==========

CreateCVar is a small plugin for vim that allows you to declare new variables
at the top of your function as well as move variables which are declared
inline to the top of your function.  This is useful if working in C89 where
it's actually an error to declare a variable after the preamble:

```c
int main()
{
    int a = 1;
    foo();
    int b = 2; /* error in C89! */
}
```

This plugin allows you to move the declaration of `b` to the top of the
function using `MoveVarToTopOfFunction()`.  This can be mapped in to
anything you like.

`NewVarAtTopOfFunction()` works slightly differently.  Let's say you are
writing some code and you realize you need a new iterator variable.  You can
use this function to create an entirely new variable from anywhere in the
function, declared at the top.  It will prompt you for the type, name and
value you want to use, create the variable and show you where it is, sleep for
1.5 seconds, then move you back to where you were.

For both functions, indentation of the inserted variable is done with
`equalprg`, so you'll need to have that set up properly (try indenting a line
with `==`).  Each function creates a mark ('v'), so you can jump back to the
variable declaration with ```v`` or `'v`.


## Example mappings

```vim
nnoremap <Leader>dv :call NewVarAtTopOfFunction()<CR>
nnoremap <Leader>mv :call MoveVarToTopOfFunction()<CR>
```
