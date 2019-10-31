# procedural-brainfuck
## Description
Version of brainfuck interpreter with procedures. Usual brainfuck description: https://en.wikipedia.org/wiki/Brainfuck
## Building it
```
./build.sh all
```
<br>
Now the pbf interpreter should be in `bin/` directory.
<br>

## Command table

|Command                 |Description              |
|------------------------|-------------------------|
|`>`                     | Move array ptr right.   |
|`<`                     | Move array ptr left.    |
|`+`                     | Add 1 to current array value|
|`-`                     | Substract 1 from current array value|
|`[`                     | Begin loop              |
|`]`                     | End loop                |
|`!`*                    | Exit procedure          |
|`?`*                    | `!` if current value is 0 |
|`;`                     | Says the end of name that should be called |

<b>*</b> – Not yet implemented 
## Procedures
```
procedure_name{...}
```
<br>
Calling it:<br>

```
procedure_name;
```

## Hello, world!
Here is code of "Hello, world!" with use of procdeures.
```
h{++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++
 .>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.
 ------.--------.>+.>.}h;
 ```
 To test this code:<br> 
 ```
 $ cd bin/
 $ ./pbf < ../examples/example.pbf
 Hello world!
 $
 ```