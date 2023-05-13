function search_number_plate(noPlate, filename)
    % Open the text file for reading
    fid = fopen(filename, 'r');
    
    % Initialize a flag indicating whether the number plate is found
    found = false;
    
    % Read the header line
    headerLine = fgets(fid);
    
    % Read the data lines and search for the number plate
    tline = fgets(fid);
    while ischar(tline)
        data = strsplit(strtrim(tline), ',');
        if strcmp(data{1}, noPlate)
            found = true;
            break;
        end
        tline = fgets(fid);
    end
    
    % Close the file
    fclose(fid);
    
    % Print the result
    if found
        fprintf('Number Founded ! Yes\n');
    else
        fprintf('Number Not Found :( No\n');
    end
end