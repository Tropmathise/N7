# G = (V,E) = ([s1,s2,...],[(s1,s2),(s2,s3),..])

# Initialisation et création du type "graph"
sommet = Int64
poids = Float64
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

############################################################ FONCTIONS SANS AFFICHAGE ########################################

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

# Bellman_Ford modifié pour calculer le chemin le plus long
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

function Bellman_Ford_vitesse(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemin(Int64)
    end
    d[s,1] = typemax(Int64)
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = typemin(Int64)
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                poids = arc[3]
                dist = max(dist,min(d[depart,k-1],poids))
            end
            d[i,k] = max(d[i,k-1],dist)
        end
    end
    return d[:,nb_sommets]
end

################################################## FONCTION AVEC AFFICHAGE ######################################################

# fonction récursive affichant les chemins empruntés
function afficherChemin(chemin::Array{Int64,1},num::Int64)
    if num<0
        return
    end
    afficherChemin(chemin, chemin[num])
    print(num," ")
end

# Fonction Bellman ford avec affichage des chemins les plus courts
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
        println("Distance min depuis la source ",s ," jusqu'au sommet ", k, " = ", d[k])
        print("chemin emprunté : ")
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
                if d[depart,k-1]+poids > dist
                    dist = d[depart,k-1]+poids
                    chemin[arrivee]=depart
                end
            end
            d[i,k] = dist
        end
    end
    dmin=d[:,nb_sommets]
    for k in 1:nb_sommets
        println("Distance max de la source ",s, " jusqu'au sommet ",k," = ", dmin[k])
        print("le chemin est : ")
        afficherChemin(chemin,k)
        println("")
    end
end

function Bellman_Ford_vitesse_aff(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    chemin = -ones(Int64,nb_sommets)
    d = zeros(nb_sommets,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemin(Int64)
    end
    d[s,1] = typemax(Int64)
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = typemin(Int64)
            chemin_possible = copy(chemin)
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                arrivee = arc[2]
                poids = arc[3]
                if min(d[depart,k-1],poids)>dist
                    if d[depart,k-1]<poids
                        dist = d[depart,k-1]
                    else
                        dist = poids
                    end
                    chemin_possible[arrivee] = depart
                end
            end
            # d[i,k] = max(d[i,k-1],dist)
            if dist > d[i,k-1]
                d[i,k] = dist
                chemin = copy(chemin_possible)
            else
                d[i,k] = d[i,k-1]
            end
        end
    end
    dmaxmin = d[:,nb_sommets]
    for k in 1:nb_sommets
        println("Plus petite vitesse max depuis la source ",s, " jusqu'au sommet ",k," = ", dmaxmin[k])
        print("le chemin est : ")
        afficherChemin(chemin,k)
        println("")
    end
    return dmaxmin
end

################################################## 2.2 #################################################################

#Fonction Bellman ford avec affichage des chemins les plus longs, lorsque les poids sont des probabilités (utilisation du log)
function Bellman_Ford_aff_max_log(G::graph,s::sommet)
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
                poids = log(arc[3]) # On modifie simplement le poids par le log du poids
                if d[depart,k-1]+poids > dist
                    dist = d[depart,k-1]+poids
                    chemin[arrivee]=depart
                end
            end
            d[i,k] = dist
        end
    end
    dmin=d[:,nb_sommets]
    for k in 1:nb_sommets
        println("Probabilité maximale de réussir jusqu'à l'étape ", k," depuis la source est ", exp(dmin[k]))
        print("la suite des étapes est : ")
        afficherChemin(chemin,k)
        println("")
    end
end

#Fonction Bellman ford avec affichage des chemins les plus longs, lorsque les poids sont des probabilités (utilisation des multiplications)
function Bellman_Ford_aff_max_mult(G::graph,s::sommet)
    S = G.S
    A = G.A
    nb_sommets = length(S)
    nb_aretes = length(A)
    d = zeros(nb_sommets,nb_sommets)
    chemin = -ones(Int64,nb_sommets)
    for i in 1:nb_sommets
        d[i,1] = typemin(Int64)
    end
    d[s,1] = 1
    for k in 2:nb_sommets
        for i in 1:nb_sommets
            dist = d[i,k-1]
            Arcs = trouve_arcs(G,i)
            for a in 1:length(Arcs)
                arc = Arcs[a]
                depart = arc[1]
                arrivee=arc[2]
                poids = arc[3]
                if d[depart,k-1]*poids > dist
                    dist = d[depart,k-1]*poids
                    chemin[arrivee]=depart
                end
            end
            d[i,k] = dist
        end
    end
    dmin=d[:,nb_sommets]
    for k in 1:nb_sommets
        println("Probabilité maximale de réussir jusqu'à l'étape ", k," depuis la source est ", dmin[k])
        print("la suite des étapes est : ")
        afficherChemin(chemin,k)
        println("")
    end
end

################################################## EXEMPLE DE GRAPHES #################################################################

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
graph_vit_connexion = graph([1,2,3,4,5,6,7],[(7,1,5),(7,4,1),(7,6,3),(1,7,5),(1,2,4),(2,1,4),(2,3,1),(2,4,2),(2,5,2),(3,2,1),(3,5,2),(4,7,1),(4,2,2),(4,5,3),(4,6,5),(5,2,2),(5,3,2),(5,4,3),(6,7,3),(6,4,5)])

# Graphes pour le tp 5-6
graph_potentiel_tache1 = graph([1,2,3,4,5,6],[(1,2,2),(1,3,2),(2,4,3),(3,4,1),(4,6,4),(3,5,1),(5,6,1)])
graph_potentiel_tache_job = graph([1,2,3,4,5,6,7,8],[(1,2,0),(2,3,6),(3,4,7),(4,8,0),(1,5,0),(5,6,3),(6,7,5),(7,8,1)])

# Graphe 2.2
graph_fabrication = graph([1,2,3,4,5,6,7,8,9,10,11,12,13],[(1,2,0.98),(1,3,0.97),(1,4,0.99),(2,5,0.96),(2,6,0.95),(3,6,0.97),(3,7,0.98),(4,7,0.95),(4,8,0.93),(5,9,0.99),(6,9,0.96),(7,9,0.97),(7,10,0.98),(8,10,0.99),(9,11,0.98),(9,12,0.99),(10,11,0.96),(10,12,0.99),(11,13,0.99),(12,13,0.93)])

###################################################################### TESTS avec affichage ##################################################################

println("-------------------------------------------------------------------------")
println("Chemins les plus courts")
println("-------------------------------------------------------------------------\n")
println("Graphe simple contenant trois sommets\n")
Bellman_Ford_aff_min(graph0,1)
println("")
println("Exemple du sujet, partant de A (les sommets sont numérotés par ordre alphabétique)\n")
Bellman_Ford_aff_min(graph_sujet,1)
println("\n-------------------------------------------------------------------------")
println("Chemins les plus longs")
println("-------------------------------------------------------------------------\n")
println("Graphe simple contenant trois sommets\n")
Bellman_Ford_aff_max(graph0,1)
println("")
println("Exemple du sujet, partant de A (les sommets sont numérotés par ordre alphabétique)\n")
Bellman_Ford_aff_max(graph_sujet,1)
println("\n-------------------------------------------------------------------------")
println("Chemins maximisant la plus petite vitesse dans un réseau de transmission")
println("-------------------------------------------------------------------------\n")
println("Exemple du sujet, partant de P (le processeur central est numéroté 7, les autres processeurs sont numérotés comme sur le sujet)\n")
Bellman_Ford_vitesse_aff(graph_vit_connexion,7)
println("\n-------------------------------------------------------------------------")
println("Fiabilité de procédé de fabrication de semi-conducteurs")
println("-------------------------------------------------------------------------\n")
println("Exemple du sujet méthode (a)\n")
Bellman_Ford_aff_max_log(graph_fabrication,1)
println("")
println("Exemple du sujet méthode (b)\n")
Bellman_Ford_aff_max_mult(graph_fabrication,1)
println("\n-------------------------------------------------------------------------")
