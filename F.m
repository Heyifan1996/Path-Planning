function [ rows ] = F( tempp,C )
rows=0;
for i=1:length(C)
    rows=rows+1;
    if tempp==C(i,:);
        break
    end
end
end

