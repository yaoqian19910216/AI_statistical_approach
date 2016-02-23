function kmat = computestringkernelmat(left, right, p)
    %%compute the cross kernel matrix between an array of strings on the
    %%left and on the right
    
   m = length(left);
   n = length(right);
   
   kmat = zeros(m, n);
   for i = 1:m
       for j = 1:n
           s = char(left(i));
           t = char(right(j));
           for k = 1:length(s) - p +1
               x = s(k:k+p-1);
               
               %%check to see if this is the first occurrence of this
               %%substring in x itself
               idself = strfind(s, x);
               if (idself(1) == k)
                   %%this is the first occurrence of this substring
                   idx = strfind(t, x);
                   kmat(i, j) = kmat(i, j) + (length(idx) > 0);
               end
               
           end
       end
   end
   