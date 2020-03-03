% JN Kather 2018-2020
% This is part of the DeepHistology repository
% License: see separate LICENSE file 
% 
% documentation for this function:
% this function will parse block (tile) filenames and 
% extract the name of the parent whole slide image (WSI)


function myList = block2filename(myList)

maxList = numel(myList);
% THIS IS for blocks that have been produced with the matlatb script and
% have the syntax <IMAGE>-blk-<RANDOM>

if contains(myList{1},'-blk-')
    disp('-- auto detected block syntax <IMAGE>-blk-<RANDOM>');

    for i=1:maxList
        [~,myList{i},~] = fileparts(myList{i}); % remove path and suffix
        blk = strfind(myList{i},'-blk-');
        myList{i} = myList{i}(1:(blk-1)); % remove "-blk-*"
       if mod(i,round(maxList/5))==0
        disp(['this block belongs to image ',...
            char(myList{i}),' parsed ',num2str(round(i/maxList*100)),'%']);
        end
    end
    
elseif contains(myList{1},'_(')
    
% THIS IS for blocks created with the QuPath script and have the syntax 
% <IMAGE>_(<coordX>,<coordY>)

    disp('-- auto detected block syntax <IMAGE>_(<coordX>,<coordY>)');
    
    for i=1:maxList
        [~,myList{i},~] = fileparts(myList{i}); % remove path and suffix
        blk = strfind(myList{i},'_(');
        if isempty(blk)
            warning(['found corrupt tile file ',char(myList{i})]);
            myList{i} = 'CORRUPT_TILE_FILE';
        else
            myList{i} = myList{i}(1:(blk(1)-1)); 
        end
        
       if mod(i,round(maxList/5))==0
        disp(['this block belongs to image ',...
            char(myList{i}),' parsed ',num2str(round(i/maxList*100)),'%']);
        end
    end
    
%     if contains(myList{1},'Rainbow')
%         warning(' --- starting RAINBOW BREAST CANCER workaround');
%        
%         for i=1:maxList
%         [~,myList{i},~] = fileparts(myList{i}); % remove path and suffix
%         myList{i} = ['rainbow-', myList{i}(11:(end-1))]; 
%            if mod(i,round(maxList/5))==0
%             disp(['this block belongs to image ',...
%                 char(myList{i}),' parsed ',num2str(round(i/maxList*100)),'%']);
%            end
%         end
%     end
else

% THIS IS for blocks that have been produced with the matlab script and
% have the syntax <IMAGE>.<REST>

    disp('-- auto detected block syntax <IMAGE>.<REST>');
    
    for i=1:maxList
        [~,myList{i},~] = fileparts(myList{i}); % remove path and suffix
        blk = strfind(myList{i},'.');
        myList{i} = myList{i}(1:(blk(1)-1)); 
       if mod(i,round(maxList/5))==0
        disp(['this block belongs to image ',...
            char(myList{i}),' parsed ',num2str(round(i/maxList*100)),'%']);
        end
    end
    
end
    
end
