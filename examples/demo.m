% Compare speed between load() and readSeparatedNumbers().
% Place the function file 'readSeparatedNumbers.m' in the same folder as this file.

clc
clear example1 example2 example3 example4

FILEROWS = 2160;
FILECOLUMNS = 2560;

disp('Reading 4 files with readSeparatedNumbers()');
timerVal = tic;
% readSeparatedNumbers() reads the file. Setting typename to uint16 means only positive integers up to 65535 can be stored, this saves memory if a lot of files were to be loaded simultaneously.
example1 = readSeparatedNumbers('ExampleData1.dat',[FILEROWS, FILECOLUMNS],typename='uint16');
example2 = readSeparatedNumbers('ExampleData2.dat',[FILEROWS, FILECOLUMNS],typename='uint16');
example3 = readSeparatedNumbers('ExampleData3.dat',[FILEROWS, FILECOLUMNS],typename='uint16');
example4 = readSeparatedNumbers('ExampleData4.dat',[FILEROWS, FILECOLUMNS],typename='uint16');
toc(timerVal);

disp('Now reading the same 4 files with load()');
timerVal = tic;
example1 = load('ExampleData1.dat');
example2 = load('ExampleData2.dat');
example3 = load('ExampleData3.dat');
example4 = load('ExampleData4.dat');
toc(timerVal);

clear example1 example2 example3 example4