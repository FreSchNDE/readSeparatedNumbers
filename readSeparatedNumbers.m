function content = readSeparatedNumbers(filepath, sizeA, options)
% READSEPARATEDNUMBERS - Read numeric data from a text file and parse it into an array
%
% Syntax:
%   content = readSeparatedNumbers(filepath, sizeA, options)
%
% Description:
%   This function reads numeric data from a text file specified by 'filepath'
%   and parses it into a numerical array. The data in the file should be
%   whitespace-separated or tab-separated. You can specify the expected
%   size of the resulting numerical array using 'sizeA' and the data type using
%   the Name-Value pair 'typename'.
%
% Input Arguments:
%   - filepath (char/string): The path to the input text file.
%
%   - sizeA (numeric, optional): The dimensions of the expected numerical array.
%     You can specify it as Inf (default), a positive integer, or a two-element
%     row vector [m, n], where 'm' represents the number of rows, and 'n'
%     represents the number of columns for the output array. When 'sizeA' is set
%     to Inf, the function reads the input data to the end, resulting in a column
%     vector.
%
%   - Name-Value options:
%     - typename (char): The data type for the output array. It should be one of
%       the valid MATLAB data types (e.g., 'single', 'double', 'int8', 'uint16',
%       etc.). The default is 'double'.
%
% Output:
%   - content (numeric array): The parsed numeric data from the text file in the
%     specified data type and dimensions [m, n].
%
% Example:
%   To read a file 'data.txt' containing tab-separated numbers and store them as
%   a uint16 array with dimensions [2160, 2560]:
%
%   content = readSeparatedNumbers('data.txt', [2160, 2560], typename = 'uint16');
%
%   To read the entire file content into a double-precision column vector:
%
%   content = readSeparatedNumbers('data.txt');
%
%   To read only the first 100 numbers from the file and store them as int32:
%
%   content = readSeparatedNumbers('data.txt', 100, typename = 'int32');
%
% Notes:
%   - The function is designed for faster performance compared to alternatives like
%     fscanf() or load().
%
% See also:
%   fopen, fread, sscanf, cast

arguments
    filepath {mustBeFile}
    sizeA {mustBeNumeric, mustBePositive, mustBeReal} = Inf
    options.typename {mustBeMember(options.typename,{'single','double', 'logical', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'})} = 'double'
end

% Open the text file for reading
fileID = fopen(filepath, 'r');

if fileID == -1
    error('Failed to open the file at: "%s"', filepath);
end

% Read file content into ?x1 char array:
content = fread(fileID, '*char');
% Format char array into a double array:
[content,~,errmsg] = sscanf(content, '%f', sizeA);
content = content';

% Close the file
fclose(fileID);


% SLOWER ALTERNATIVE:
% If ?x1 cell array (where each cell contains a char array) is needed use split instead of sscanf:
% content = split(content, char(9));
% That cell array could then be concatenated into one for example space-separated string with:
% combinedString = sprintf(' %s', content{:});
% Afterwards it could be parsed with:
% content = sscanf(combinedString, '%f');

if ~isempty(errmsg)
    error(errmsg);
end

if ~strcmp(options.typename, 'double')
    content = cast(content, options.typename);
end

end