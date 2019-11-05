#!/usr/bin/octave -qf

# example octave script

arg_list = argv ();
num = str2int(arg_list{1});

printf ("Name of Octave script: ", program_name ());

tic();
for i=1:num
   a(i) = i;
endfor
elapsed = toc();

printf("Elapsed time: %.4f seconds", elapsed);