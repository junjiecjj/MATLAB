close all;
clear all;
clc;


string  = 'Hello, world';

size(string);
abs(string);

string(8:12);

string(12:-1:8);

string1  = 'It''s not Hello, world';

U = 'Hello, ';
V = 'World!';

[U, V];

eval('1+1')
 
%从一个字符串内找出字符串
findstr('Hello ,world','wor')

%字符串比较
findstr('world','world')

%str(sprintf('World, %d',1222))

str2mat('Hello')

tmp = 'jack';
str1  = sprintf('hello,%s, you are %d years old\n',tmp,12)
if strcmp(str1,'hello,jack, you are 12 years old')
    100
end

C = { 1,   2,   3 ;
     'AA','BB','CC'};

str = sprintf(' %d %s',C{:})




