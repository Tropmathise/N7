function W = calcul_W(N,theta,p)

d = p-1;

% Define the number of angles.
nA = length(theta);

% The starting values both the x and the y coordinates.
x0 = linspace(-d/2,d/2,p)';
y0 = zeros(p,1);

% The intersection lines.
x = (-N/2:N/2)';
y = x;

% Initialize vectors that contains the row numbers, the column numbers
% and the values for creating the matrix W efficiently.
rows = zeros(2*N*nA*p,1);
cols = rows;
vals = rows;
idxend = 0;
    
II = 1:nA;
JJ = 1:p;

% Loop over the chosen angles.
for i = II
    
    % All the starting points for the current angle.
    x0theta = cosd(theta(i))*x0-sind(theta(i))*y0;
    y0theta = sind(theta(i))*x0+cosd(theta(i))*y0;
    
    % The direction vector for all rays corresponding to the current angle.
    a = -sind(theta(i));
    b = cosd(theta(i));
    
    % Loop over the rays.
    for j = JJ
        
        % Use the parametrisation of line to get the y-coordinates of
        % intersections with x = constant.
        tx = (x - x0theta(j))/a;
        yx = b*tx + y0theta(j);
        
        % Use the parametrisation of line to get the x-coordinates of
        % intersections with y = constant.
        ty = (y - y0theta(j))/b;
        xy = a*ty + x0theta(j);
        
        % Collect the intersection times and coordinates.
        t = [tx; ty];
        xxy = [x; xy];
        yxy = [yx; y];
        
        % Sort the coordinates according to intersection time.
        [~,I] = sort(t);
        xxy = xxy(I);
        yxy = yxy(I);
        
        % Skip the points outside the box.
        I = (xxy >= -N/2 & xxy <= N/2 & yxy >= -N/2 & yxy <= N/2);
        xxy = xxy(I);
        yxy = yxy(I);
        
        % Skip double points.
        I = (abs(diff(xxy)) <= 1e-10 & abs(diff(yxy)) <= 1e-10);
        xxy(I) = [];
        yxy(I) = [];
        
        % Calculate the length within cell and determines the number of
        % cells which is hit.
        aval = sqrt(diff(xxy).^2 + diff(yxy).^2);
        col = [];
        
        % Store the values inside the box.
        if numel(aval) > 0
            
            % If the ray is on the boundary of the box in the top or to the
            % right the ray does not by definition lie with in a valid cell.
            if ~((b == 0 && abs(y0theta(j) - N/2) < 1e-15) || ...
                    (a == 0 && abs(x0theta(j) - N/2) < 1e-15)       )
                
                % Calculates the midpoints of the line within the cells.
                xm = 0.5*(xxy(1:end-1)+xxy(2:end)) + N/2;
                ym = 0.5*(yxy(1:end-1)+yxy(2:end)) + N/2;
                
                % Translate the midpoint coordinates to index.
                col = floor(xm)*N + (N - floor(ym));
                    
            end
        end
        if ~isempty(col)
			% Create the indices to store the values to vector for
			% later creation of W matrix.
			idxstart = idxend + 1;
			idxend = idxstart + numel(col) - 1;
			idx = idxstart:idxend;
			
			% Store row numbers, column numbers and values.
			rows(idx) = (i-1)*p + j;
			cols(idx) = col;
			vals(idx) = aval;
        end
    end % end j
end % end i

% Truncate excess zeros.
rows = rows(1:idxend);
cols = cols(1:idxend);
vals = vals(1:idxend);
    
% Create sparse matrix W from the stored values.
W = sparse(rows,cols,vals,p*nA,N^2);
