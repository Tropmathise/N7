#!/bin/bash
PATH_DOSSIER='/home/tsadurni/Documents/Annee_2/DR/hidoop/src'     #changer en fonction de votre session
SUFFIX='.enseeiht.fr'
CLIENT='carapuce'${SUFFIX}
NAMENODE='salameche'${SUFFIX}
WORKER1='magicarpe'${SUFFIX}
WORKER2='roucool'${SUFFIX}
WORKER3='rondoudou'${SUFFIX}
USER=tsadurni #à changer

echo "------------Execution du script------------"
rmiregistry &
echo
echo "-----------Lancement du NameNode-----------"
echo
ssh ${USER}@${NAMENODE} "cd ${PATH_DOSSIER} && java hdfs.NameNode 8080"&
echo
echo "-----------Lancement des Workers et serveurs-----------"
ssh ${USER}@${WORKER1} "cd ${PATH_DOSSIER} && java ordo.WorkerImpl machine1 8081"&
ssh ${USER}@${WORKER2} "cd ${PATH_DOSSIER} && java ordo.WorkerImpl machine2 8082"&
ssh ${USER}@${WORKER3} "cd ${PATH_DOSSIER} && java ordo.WorkerImpl machine3 8083"&
echo
echo
echo "-----------Lancement des serveurs -----------"
ssh ${USER}@${WORKER1} "cd ${PATH_DOSSIER} && java hdfs.HdfsServeur 1 8080"&
ssh ${USER}@${WORKER2} "cd ${PATH_DOSSIER} && java hdfs.HdfsServeur 2 8080"&
ssh ${USER}@${WORKER3} "cd ${PATH_DOSSIER} && java hdfs.HdfsServeur 3 8080"&
echo
echo
echo "-----------Lancement du client -----------"
ssh ${USER}@${CLIENT} "cd ${PATH_REPO} && java application.MyMapReduce test"

