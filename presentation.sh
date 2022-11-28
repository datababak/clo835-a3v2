#!/bin/bash
#kubectl delete ns lab3
#kubectl delete sc standard

clear
kubectl create ns lab3
kubectl get nodes
printf "\n\n"
read -p ">>> 2 nodes running, TASK1 completed, press any key to proceed to creating a Storage Class"
cd task2/
clear
kubectl get sc
printf "\n\n"
read -p ">>> There exists a default Storage Class & we are going to create our Storage Class named 'standard'"
kubectl apply -f sc-standard.yaml
kubectl get sc
printf "\n\n"
read -p ">>> Press any key to see the details of the provisioned Storage Class"
kubectl describe sc standard
printf "\n\n"
read -p ">>> Standard/GP2; TASK2 completed, let's create a PVC for our db & see the details"
cd ../task3/
clear
kubectl apply -f db-pvc4sc.yaml -n lab3
kubectl describe pvc -n lab3
printf "\n\n"
read -p ">>> mysql-pvc/gp2/labels; TASK3 Done! let's provision our db with the storage claim for AWS EBS through SVC & SC"
cd ../task4/
clear
kubectl apply -f db-dep-pvc.yaml -n lab3
sleep 3
kubectl get all -n lab3
echo "be patient it is making the db & storage ready" && sleep 10
clear
kubectl get all -n lab3
kubectl get pvc mysql-pvc -n lab3
echo "let's wait for  10 more seconds" && sleep 10
clear
kubectl get all -n lab3
kubectl get pvc mysql-pvc -n lab3
printf "\n\n"
read -p ">>> PVC Bound/PV in EC2/Where's PVC?/ ... & lunch the ClusterIp service for our db"
clear
kubectl apply -f db-svc.yaml
sleep 5
kubectl get all -n lab3
printf "\n\n"
read -p "TASK4 completed, Now answer 3 questions for task5 "
clear
read -p "Was EBS volume created by Amazon EKS at step 4 or step 5? "
read -p "Which AZ was the volume deployed at?"
read -p "Why was it deployed in this AZ? Explain."
printf "\n\n"
read -p ">>> TASK5 Completed/.. Let's provision the web server application with 2 replicas"
cd ../task6/
clear
kubectl apply -f app-dep.yaml
sleep 7
kubectl get all -n lab3
printf "\n\n"
read -p ">>> 2 replics/ ... & let's expose the application using service of type LoadBalancer"
clear
kubectl apply -f app-lb.yaml
kubectl get svc lb-app-name -n lab3
printf "\n\n"
read -p ">>> TASK6 Completed/.. Let's do some data entry"
clear
read -p ">>> TASK7: Find out the node that hosts MySQL pod"
kubectl get nodes
kubectl get pods -n lab3 -o wide
printf "\n"
read -p ">>> Now, delete the MySQL pod and let Replicaset controller redeploy it"
echo "Enter the name of the db-pod here"
read dbpodname
kubectl delete pod $dbpodname -n lab3
printf "\n"
read -p ">>>What node is the MySQL pod running on? Can you still see the data you populated in step 6? "
kubectl get nodes
kubectl get pods -n lab3 -o wide
printf "\n"
read -p ">>Explain why the data is still available and the reason the node that hosts the MySQL pod remains the same? "
clear
read -p ">>TASK 8.	Use static storage provisioning with hostPath volume type"
read -p ">>Create PV and PVC manifests and deploy PVC for hostPath PV"
cd ../task8/
clear
read -p "kubectl apply -f db-pv.yaml"
kubectl apply -f db-pv.yaml
read -p "kubectl apply -f db-pvc.yaml"
kubectl apply -f db-pvc.yaml
read -p "kubectl apply -f db-dep-hp.yaml"
kubectl apply -f db-dep-hp.yaml 
read -p "k get pv db-pv-static-name -n lab3"
kubectl get pv db-pv-static-name -n lab3
read -p "k get pvc db-pvc-t8-name -n lab3"
kubectl get pvc db-pvc-t8-name -n lab3
read -p "k get deployment db-hp-name -n lab3"
kubectl get deployment db-hp-name -n lab3
read -p ">>> TASK9: Find out the node that hosts MySQL pod"
clear
kubectl get nodes
kubectl get pods -n lab3 -o wide
printf "\n"
read -p ">>> Now, delete the MySQL pod and let Replicaset controller redeploy it"
echo "Enter the name of the db-pod here"
read dbpodname2
kubectl delete pod $dbpodname2 -n lab3
printf "\n"
read -p ">>>What node is the MySQL pod running on? Can you still see the data you populated in step 8? "
kubectl get nodes
kubectl get pods -n lab3 -o wide
printf "\n"
read -p ">>Explain what would happen if the MySQL pod is scheduled to a different node?"
read -p ">>Would the data from step 8 still be available? "

read -p ">> Thank You! << "
