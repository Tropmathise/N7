function [u,A]=elliptic_f(Q1,n)
    fun=@(x)f(x);
    if(~Q1)
        [coordinates, elements3, elements4, dirichlet, ~] = maillage_carre(n);
        A=A_triangle(coordinates, elements3);
        [~,b]=b_dirichlet_t(coordinates, A, elements3, dirichlet, fun);
        u=zeros(n*n,1);
        free=setdiff(1:length(coordinates),dirichlet);
        u(free)=A(free,free)\b(free);
        show(elements3,elements4,coordinates,u);
    else 
        coordinates=load('coordinates.dat');
        dirichlet=load('dirichlet.dat');
        elements3=load('elements3.dat');
        elements4=load('elements4.dat');
        neumann=load('neumann.dat');
        A=A_quadrangle(coordinates,elements3, elements4);
        [u, b]=b_quadrangle(coordinates, A, elements3, elements4, dirichlet, neumann, fun);
        free=setdiff(1:length(coordinates),dirichlet);
        u(free)=A(free,free)\b(free);
        show(elements3,elements4,coordinates,u);
    end
end

%% Construction de la matrice de raideur M relative à un élément triangle
% Prend une matrice 3*2 qui correspond aux coordonnées des noeuds du triangle
% Renvoie la matrice de Raideur associée 3*3
% correspond à la formule 10 du sujet
function M = raideurTriangle(elt)
    t=size(elt,2);
    P=[ones(1,t+1);elt'];
    nablaEta=P\[zeros(1,t);eye(t)];
    T=det(P)/2;
    M=T*nablaEta*nablaEta';
end

%% Assemblage de la matrice A dans le cas d'un maillage constitué uniquement d'élements triangles
% renvoie la matrice A assemblée pour les triangles
function A_triangle = A_triangle(coordinates, elements3)
    n=size(coordinates,1);
    A_triangle=zeros(n);
    for i=1:size(elements3,1)
        elt=coordinates(elements3(i,:),:);
        % on récupère la matrice de raideur M
        M=raideurTriangle(elt);
        % On construit la matrice A définie au 3.1 du sujet
        for j=1:size(elements3,1)
            A_triangle(elements3(j,:),elements3(j,:))=A_triangle(elements3(j,:),elements3(j,:))+M;
        end
    end
end

%% Construction du second membre pour les triangles
% Fonction pour les centres de gravité du du triangle
% correspond à la formule 4 
function b = b_triangle(eltTriangle,fun)
    x=eltTriangle(:,1);
    y=eltTriangle(:,2);
    P=[x(2)-x(1) x(3)-x(1); y(2)-y(1) y(3)-y(1)];
    alpha = det(P);
    T=alpha/6;
    % caclul des centres de gravité
    x_g=(x(1)+x(2)+x(3))/3;
    y_g=(y(1)+y(2)+y(3))/3;
    coord_g = [x_g y_g];
    % calcul de b
    b=T*fun(coord_g);
end
    
%% Assemblage du second membre dans le cas des conditions de Dirichlet uniquement
function [u_dir, b] = b_dirichlet_t(coordinates, A, elements3, dirichlet, fun)
    n=size(coordinates,1);
    b=zeros(n,1);
    % parcours des triangles
    for i=1:size(elements3,1)
        elt=coordinates(elements3(i,:),:);
        b_tri=b_triangle(elt,fun);
        for j=1:3
            b(elements3(i,j))=b(elements3(i,j))+b_tri;
        end
    end
    % conditions de dirichlet
    u_dir=zeros(size(b,1),1);
    u_dir(dirichlet)=u_d(coordinates(dirichlet,:));
    b=b-A*u_dir;
end


%% On refait pareil pour les quadrangles

%% Construction de la matrice de raideur M relative à un élément quadrangle
function M = raideurQuadrangle(eltquadrangle)
    Jphi = [eltquadrangle(2,:)-eltquadrangle(1,:);eltquadrangle(4,:)-eltquadrangle(1,:)]';
    det_Jphi = det(Jphi);
    J=inv(Jphi'*Jphi);
    a=J(1,1);
    b=J(1,2);
    c=J(2,2);
    M=det_Jphi*[2*(a+c)+3*b -2*a+c -((a+c)+3*b) a-2*c;
        -2*a+c 2*(a+c)-3*b a-2*c -(a+c)+3*b;
        -((a+c)+3*b) a-2*c 2*(a+c)+3*b  -2*a+c;
        a-2*c -(a+c)+3*b -2*a+c 2*(a+c)-3*b]/(6);
end

%% Assemblage de la matrice A dans le cas d'un maillage constitué uniquement d'éléments quadrilatères
% renvoie la matrice A assemblée pour les quadrangles
function A = A_quadrangle(coordinates, elements3, elements4)
    %on reprend la matrice A des triangles
    A=A_triangle(coordinates,elements3);
    for i=1:size(elements4,1)
        elt=coordinates(elements4(i,:),:);
        % on récupère la matrice de raideur M
        M=raideurQuadrangle(elt);
        % On construit la matrice A 
        for j=1:size(elements4,1)
            A(elements4(j,:),elements4(j,:))=A(elements4(j,:),elements4(j,:))+M;
        end
    end
end

%% Construction du second membre pour les quadrilatères
% Fonction pour les centres de gravité du du quadrangle
function b = b_quad(eltQuad,fun)
    x=eltQuad(:,1);
    y=eltQuad(:,2);
    P=[x(2)-x(1) x(4)-x(1); y(2)-y(1) y(4)-y(1)];
    alpha = det(P);
    T=alpha/4;
    % caclul des centres de gravité
    x_g=(x(1)+x(2)+x(3)+x(4))/4;
    y_g=(y(1)+y(2)+y(3)+y(4))/4;
    coord_g = [x_g y_g];
    % calcul de b
    b=T*fun(coord_g);
end

%% Assemblage du second membre dans le cas des conditions de Dirichlet uniquement
% Cette fonction fait appel à b_dirichlet_t pour ajouter les élements
% quadrangles à b
% Renvoie b et u_dir
function [u_dir,b] = b_quadrangle(coordinates, A, elements3, elements4, dirichlet, neumann, fun)
    % parcours des quadrangles
    [u_dir,b]=b_dirichlet_t(coordinates, A, elements3, dirichlet, fun);
    for i=1:size(elements4,1)
        elt=coordinates(elements4(i,:),:);
        b_qua=b_quad(elt,fun);
        for j=1:4
            b(elements4(i,j))=b(elements4(i,j))+b_qua;
        end
    end
    %condition de Neumann
    for j = 1:size(neumann,1)
        b(neumann(j,:))=b(neumann(j,:))+norm(coordinates(neumann(j,1),:)-coordinates(neumann(j,2),:))*g(mean(coordinates(neumann(j,:),:)))/2;
    end
end
