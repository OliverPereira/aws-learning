## Overview

To containerize the Flask API on AWS ECS using Fargate

## Note:    The ECR registry 'aws-learning-dev-ecr' needs to be present before the Docker image can be built and uploaded.
            The Terraform code will manage the creation of all the components. And once the Docker image has been uploaded to the ECR, the ECS task will automatically launch the image if the image tags match.

## Folders

docker/python-api - contains the all the files including the script to generate, tag and upload the Docker image to the AWS ECR registry 'aws-learning-dev-ecr'

    [python-api]$ ./deploy.sh
    No arguments supplied
    Usage:<script name> region repo tag

    [python-api]$./deploy.sh eu-west-2 aws-learning-dev-ecr latest

If the script is successful, it will output the latest 4 tags of the image.

    Image has been successfully uploaded to aws-learning-dev-ecr

    The latest 4 image versions are :
    [
    "latest",
    "1.1"
    ]

terraform/python-aws - contains all the files require to setup ECS including VPC, Public/Private Subnets, ECR, etc.
    The AWS credentials need to be updated in the terraform.tfvars file

## Files

python-aws-graph.svg - Contains the Arch diagram of the Terraform code and can be view in the Edge browser.
python-aws-graphviz-base.dot - Contains the Arch diagram of the Terraform code and can be view in Graphviz.

healthcheck.sh - To check if the application is up and running.

## Execution

In the terraform/python-aws folder execute the following commands setup and configure the various components.

[python-api]$ terraform init
[python-api]$ terraform validate
[python-api]$ terraform plan
[python-api]$ terraform apply

If everything goes according to the plan you will a see a similar output. Make a note of the loadbalancer DNS.

    instance_ip_addr = "496253059293.dkr.ecr.eu-west-2.amazonaws.com/aws-learning-dev-ecr"
    load_balancer_dns = "aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com"
    nat_gateway_ip = "18.170.75.219"

To check whether the application is up and running use the healthcheck script.

# LB DNS doesn't exist
$./healthcheck.sh aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com
aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com is not up, returned 000

# The container is still down
$./healthcheck.sh aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com
aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com is not up, returned 503

# The container is up and running
$./healthcheck.sh aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com
aws-learning-dev-alb-490209662.eu-west-2.elb.amazonaws.com is up and running, returned 200

Load the loadbalancer DNS into a browser and the application should load.
