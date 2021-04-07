# G = (V,E) = ([s1,s2,...],[(s1,s2),(s2,s3),..])

# Initialisation et création du type "graph"
sommet = Int64
poids = Int64
arete = Tuple{sommet,sommet,poids}

struct graph
    S::Array{sommet,1}
    A::Array{arete,1}
end

# Renvoie tous les arcs de G qui arrivent vers le sommet s
function trouve_arcs(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    L = []
    for a in 1:nb_aretes
        arete = A[a]
        if arete[2] == s
            append!(L,[arete])
        end
    end
    return L
end

# Bellman_Ford pour calculer les chemins les plus courts à partir d'une source "s" dans un graph "G"
function Bellman_Ford(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets,nb_sommets)
    chemin = -ones(Int64,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemax(Int64)
    end
    d[s,1] = 0
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = d[i,k-1]
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                arrivee=arc[2]
                poids = arc[3]
                dist = min(dist,d[depart,k-1]+poids)
                chemin[arrivee]=depart
            end
            d[i,k] = dist
        end
    end
    return d[:,nb_sommets]
end

# Bellman_Ford pour calculer le chemin le plus long
# Nous avons seulement changer la relation de recurrence et l'initialisation de "d" 
function Bellman_Ford_max(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemin(Int64)
    end
    d[s,1] = 0
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = d[i,k-1]
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                poids = arc[3]
                dist = max(dist,d[depart,k-1]+poids)
            end
            d[i,k] = dist
        end
    end
    return d[:,nb_sommets]
end


################################################## AVEC AFFICHAGE ######################################################

#fonction recursive affichant les chemins empruntés
function afficherChemin(chemin::Array{Int64,1},num::Int64)
    if num<0
        return
    end
    afficherChemin(chemin, chemin[num])
    print(num," ")
end

#Fonction Bellman ford avec affichage des chemins les plus courts
function Bellman_Ford_aff_min(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets)
    chemin = -ones(Int64,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemax(Int64)
    end
    d[s,1] = 0
    for i in 2:nb_sommets
        Arcs=trouve_arcs(G,i)
        for a in 1:length(Arcs)
            arc = Arcs[a]
            depart = arc[1]
            arrivee=arc[2]
            poids = arc[3]
            if (d[depart]+poids<d[arrivee])
                d[arrivee]=d[depart]+poids
                chemin[arrivee]=depart
            end
        end

    end
    for k in 1:nb_sommets
        println("Distance min de ", k," depuis la source est ", d[k])
        print("le chemin est : ")
        afficherChemin(chemin,k)
        println("")
    end
end


#Fonction Bellman ford avec affichage des chemins les plus longs
function Bellman_Ford_aff_max(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets,nb_sommets)
    chemin = -ones(Int64,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemin(Int64)
    end
    d[s,1] = 0
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = d[i,k-1]
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                arrivee=arc[2]
                poids = arc[3]
                dist = max(dist,d[depart,k-1]+poids)
                chemin[arrivee]=depart
            end
            d[i,k] = dist
        end
    end
    dmin=d[:,nb_sommets]
    for k in 1:nb_sommets
        println("Distance max de ", k," depuis la source est ", dmin[k])
        print("le chemin est : ")
        afficherChemin(chemin,k)
        println("")
    end
end


########################################################## SUITE DU SUJET ###############################################################

function Bellman_Ford_vitesse(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = 0
    end
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = typemax(Int64)
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                poids = arc[3]
                dist = min(dist,d[depart,k-1]+poids)
            end
            d[i,k] = max(d[i,k-1],dist)
        end
    end
    return d
end


################################################## EXEMPLE DE GRAPH #################################################################

#Graphe simple et basique 
#min : 2
#max : 3
graph0 = graph([1, 2, 3], [(1, 2, 1), (2, 3, 1), (1, 3, 3)])

#Graphe du sujet 
#min : 12
#max : 17
graph_sujet = graph([1,2,3,4,5,6], [(1,2,3),(2,3,4),(3,4,2),(5,4,9),(4,6,3),(5,2,-1),(1,5,5)])

#Graphe avec cycle negatif
graph_cycle_neg = graph([1,2,3,4],[(1,2,1),(2,3,3),(3,4,2),(4,2,-6)])

#Graphe pour les processus
graph_vit_connexion = graph([1,2,3,4,5,6,7],[(7,1,5),(7,4,1),(7,6,3),(1,7,5),(1,2,4),(2,1,4),(2,3,1),(2,4,2),(2,5,2),(3,2,1),(3,5,2),(4,7,1),(4,2,2),(4,5,3),(4,6,5),(5,2,2),(5,3,2),(5,4,3),(6,7,3),(6,5,4)])
graph_potentiel_tache = graph([1,2,3,4,5,6],[(1,2,2),(1,3,2),(2,4,3),(3,4,1),(3,5,1),(5,6,1),(4,6,4)])
