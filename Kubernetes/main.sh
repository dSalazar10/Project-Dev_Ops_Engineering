#!/bin/bash
# This script assumes minikube is running
# Start minikube: `minikube start`
function PromptUser {
    printf "\033c"
    echo "~~~~~~~~~~~~~"
    echo "| Main Menu |"
    echo "~~~~~~~~~~~~~"
    echo "Cluster: ${clustername}"
    echo ""
    echo "Select from the following options:"
    echo "1) Create Cluster"
    echo "2) Update Cluster"
    echo "3) Delete Cluster"
    echo "4) Describe Cluster"
    echo "5) Validate Template"
    echo "6) Setup Cluster"
    echo "7) Exit"
    echo "~:"
}
function Template {
    printf "\033c"
    echo "~~~~~~~~~~~~~"
    echo "| Create |"
    echo "~~~~~~~~~~~~~"
    echo ""
    # Create everything
    kubectl apply -f frontend-deployment.yml \
    && kubectl apply -f reverseproxy-deployment.yml \
    && kubectl apply -f feed-deployment.yml \
    && kubectl apply -f user-deployment.yml \
    && kubectl apply -f env-config-map.yml \
    && kubectl apply -f env-secrets.yml \
    && kubectl apply -f aws-secrets.yml

    # start a single instance of nginx
    $dname=reverse-proxy
    kubectl create deployment $dname --image=dsalazar10/udagram:$dname
    kubectl proxy
    
    # Examples
    # create resource(s)
    kubectl apply -f ./my-manifest.yaml            
    # create from multiple files
    kubectl apply -f ./my1.yaml -f ./my2.yaml      
    # create resource(s) in all manifest files in dir
    kubectl apply -f ./dir                         
    # create resource(s) from url
    kubectl apply -f https://git.io/vPieo          
    
    # get the documentation for pod manifests
    kubectl explain pods                           
    
    kubectl run reverse-proxy\
    --generator=run-pod/v1\
    --image=${dockerpath}\
    --port=80 --labels app=reverse-proxy
    echo "Cluster Update Completed."
    sleep 1
}
function Template {
    printf "\033c"
    echo "~~~~~~~~~~~~~"
    echo "| Update |"
    echo "~~~~~~~~~~~~~"
    echo ""
    # Change the image used for the Pod
    kubectl set image deployment/my-deployment my-deployment=my-new-image

    # Examples
    kubectl set image deployment/frontend www=image:v2               # Rolling update "www" containers of "frontend" deployment, updating the image
    kubectl rollout history deployment/frontend                      # Check the history of deployments including the revision 
    kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
    kubectl rollout undo deployment/frontend --to-revision=2         # Rollback to a specific revision
    kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
    kubectl rollout restart deployment/frontend                      # Rolling restart of the "frontend" deployment

    echo "Cluster Update Completed."
    sleep 1
}
function Template {
    printf "\033c"
    echo "~~~~~~~~~~~~~"
    echo "| Delete |"
    echo "~~~~~~~~~~~~~"
    echo ""
    # Delete everthing
    kubectl delete all --all

    # Examples
    kubectl delete -f ./pod.json                    # Delete a pod using the type and name specified in pod.json
    kubectl delete pod,service baz foo              # Delete pods and services with same names "baz" and "foo"
    kubectl delete pods,services -l name=myLabel    # Delete pods and services with label name=myLabel
    kubectl -n my-ns delete pod,svc --all           # Delete all pods and services in namespace my-ns,

    echo "Cluster Update Completed."
    sleep 1
}
function Template {
    printf "\033c"
    echo "~~~~~~~~~~~~~"
    echo "| Describe |"
    echo "~~~~~~~~~~~~~"
    echo ""
    # Describes the Pods in each deployment
    kubectl describe deployments

    # List of deployments
    kubectl get deployments

    # List of pods by name
    kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'

    # gets roll out status
    kubectl rollout status deployment.v1.apps/my-deployment

    # see the labels automatically generated for each Pod
    kubectl get pods --show-labels

    # List the environment ConfigMaps
    k get configmaps

    # List the environment Secrets
    k get secrets

    # Examples
    # Version Info
    kubectl version
    # DNS Info
    kubectl cluster-info
    
    kubectl describe nodes my-node
    kubectl describe pods my-pod

    # Get all pods
    kubectl get pods #-o wide
    # Get a deployment
    kubectl get deployment my-dep 
    echo "Cluster Update Completed."
    sleep 1
}
function Template {
    printf "\033c"
    echo "~~~~~~~~~~~~~"
    echo "| Validate |"
    echo "~~~~~~~~~~~~~"
    echo ""
    # This assumes the kubectl proxy command has been run
    # 
    kubectl logs $POD_NAME

    kubectl logs -l name=myLabel                        # dump pod logs, with label name=myLabel (stdout)
    kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
    kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
    kubectl logs -l name=myLabel -c my-container        # dump pod logs, with label name=myLabel (stdout)
    kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
    kubectl logs -f my-pod                              # stream pod logs (stdout)
    kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
    kubectl logs -f -l name=myLabel --all-containers    # stream all pods logs with label name=myLabel (stdout)
    kubectl run -i --tty busybox --image=busybox -- sh  # Run pod as interactive shell
    kubectl run nginx --image=nginx --restart=Never -n 
    mynamespace                                         # Run pod nginx in a specific namespace
    kubectl run nginx --image=nginx --restart=Never     # Run pod nginx and write its spec into a file called pod.yaml
    --dry-run -o yaml > pod.yaml

    
    kubectl attach my-pod -i                            # Attach to Running Container
    kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
    kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
    kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
    kubectl exec my-pod -- env                          
    kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers
    echo "Cluster Update Completed."
    sleep 1
}
function SetupCluster {
    printf "\033c"
    echo "~~~~~~~~~~~~~~~~"
    echo "| SetupCluster |"
    echo "~~~~~~~~~~~~~~~"
    echo ""
    echo "Select from the following options:"
    echo "1) Network Cluster"
    echo "~:"
    read choice
    case $choice in
        1)
            clustername="NetworkCluster"
            tempfile="network.yml"
            paramfile="network-parameters.json"
            ;;
    esac
}
function KuberentesModifications {
    SetupCluster
    choice = 0 
    PromptUser
    while read choice
    do
        case $choice in
            1)
                CreateCluster
                ;;
            2)
                UpdateCluster
                ;;
            3)
                DeleteCluster
                ;;
            4)
                DescribeCluster
                ;;
            5)
                ValidateTemplate
                read end_wait
                ;;
            6)
                SetupCluster
                ;;
            7) 
                echo "Exiting program!"
                break
                ;;
        esac
        PromptUser
    done
}
KuberentesModifications

Version info: `kubectl version`
IP / DNS info: `kubectl cluster-info`
View nodes in cluster: `kubectl get nodes`
Create a deployment: `kubectl create deployment`
