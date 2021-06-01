function f = kaczmarz(p,W,k_max)
    f=zeros(size(W,2),1);
    Wt=W';
    for k=1:k_max
        for i=1:size(W,1)
            w_i=Wt(:,i);
            p_i=p(i);
            norm_wi=norm(w_i).^2;
            if norm_wi ~= 0
                f=f+(p_i-w_i'*f/norm_wi)*w_i;
            end
        end
    end
end

