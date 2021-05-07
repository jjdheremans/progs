% Read vector from txt file
function [data] = read_matrix( filename, nline ) 
    fid = fopen(filename, 'r');
    if fid == -1, error('Cannot open file'); 
    end
    i = 1 ;
    while ~feof(fid)
        data(i) = fscanf(fid, '%g + %g*1i');
        i = i + 1 ;
    end
    fclose(fid);
    data = reshape( data' , nline, [] );
end