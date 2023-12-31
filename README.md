# Terraform-Aws-Case-Study
Auto scalable Web Server and RDS proof of concept done for the AWS cloud platform using Terraform.
In order to run this repository, sign up for an AWS free tier account if you dont have one. When you first register for AWS, you
initially sign in as the root user. Create a more-limited user account, using the Identity and Access Management (IAM) service.
AWS will show you the security credentials for that user, which consist of an Access Key ID and a Secret Access Key.
Now open a Terminal and export these keys using the below command.
```
export AWS_ACCESS_KEY_ID=<<Your Access Key>>
export AWS_SECRET_ACCESS_KEY=<<Your Secret Key>>
```
Now clone this repository to your desired path in the same terminal, go into the folder terraform-aws-case-study and run the below
commands one after the other after making sure that Terraform package is installed properly.
```terraform
terraform init
terraform plan
terraform apply
```
Type **yes** when prompted and hit Enter to deploy the VPC, RDS and autoscallable WebServers on your AWS account.
After successful execution of your Infrastructure As Code, you will get the loadbalancer url of your webserver as an output like below.
```terraform
load_balancer_output = "development-poc-lb-****.us-east-2.elb.amazonaws.com"
```
Curl this url or enter it to your browser to see this output **"Hello Team This is my IP: [private IP of the webserver]"**
Login to the AWS web console and see wheather all other resources have been properly configured. 
Once you have gone through and verified all your resources make sure you destroy all the resources in the end using the below command.
```terraform
terraform destroy
```
# Note 
In order to login to your Webservers using **ssh** and your personal private key got to the variable.tf file of the WebServer under
modules/webserver and place the contents of your public key in the default section of the public_key_value variable.
```
variable "public_key_value" {
  type = string
  default = "<<Your public Key>>" 
}
```
