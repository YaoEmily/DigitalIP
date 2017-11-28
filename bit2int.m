function [result] = bit2int(tmp, first, last)

    result = 0;
    for i = 0:last-first
        result = result + tmp(first+i)*(2^(i*8));
    end

end