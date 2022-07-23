# multi_shop


Prerequisite:

1.  Create an acm certificate for your domain name multi-cloud.<your_domain>.com

2.  Install terraform and configure aws cli on Jenkins worker nodes
    
        1.  Terraform
        2.  AWS CLI

Usage:

1.  Update the alb.ingress.kubernetes.io/certificate-arn: <arn_of_the_acm_certificate_that_was_pre-created> section within the multi_shop.yaml file

2.  Create a CI/CD pipeline on Jenkins with GitHub hook trigger for GITScm polling configured

3.  Select "Pipeline script from SCM" for Pipeline Definition -> Select Git under SCM

4.  Provide the url of the repository

5.  Click Save

6.  On Github, configure web-hook on your the "cicd-pipeline-aws-terraform-eks-fargate-multi-shop-auto-deployment" repository

7.  Manually Perform the first build

8.  When the build successfully completes, copy the Application Load Balancer address outputted to the screen and create a CNAME record where

            Host: multi-shop
            Value: k8s-default-multisho-**********.us-east-1.elb.amazonaws.com

9.  NOTE:

            When changes are made and pushed back to the repository, Jenkins will perform the required CI/CD.
