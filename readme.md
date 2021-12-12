This repo is mainly focused on to explore `terraform` and `awscli`. There are 2 sections in this repo.

- [CFT](#cft)
  - [Pros](#pros)
- [Terraform](#terraform)
    - [Run terraform](#run-terraform)
  - [Pros](#pros-1)
- [Issues faced during learning](#issues-faced-during-learning)
- [Solutions](#solutions)
- [To create terraform image](#to-create-terraform-image)
- [To create AWS cli image](#to-create-aws-cli-image)

#### CFT
To test the above CFT, Please create a stack in CFT in aws console with all the defaults provided in the console, in this template:

1. Creates a user
2. Attaches policies required to receive message from SQS, send message to SNS
3. Permission is added to only the particular resources
4. Created user's secret key is stored in secrets manager

##### Pros
1. AWS provides the CFT, any resouce created with CFT can be deleted by the stack can be removed using delete stack in console
2. Provides UI to do a lot configuration
3. Designer is available
4. Readymade templates


#### Terraform

In this `main.tf`,

1. Adds `AWS` as provider
2. Adds SQS and SNS with `fifo` as `true`

###### Run terraform
1. Make sure to install terraform
2. Run `terraform init`
3. Run `terraform fmt` to format the file
4. Run `terraform validate` to validate the file
5. Run `terraform apply` to create the resouces in AWS

##### Pros
1. Community and enterprise version available
2. Easy access to cli options (just by running `terraform destroy` it deleted all the resources)
3. Cross providers (AWS, GCP, Azure, Docker)


#### Issues faced during learning
As part of the above POC, I came accross few problems:
1. Doing AWS configure for different users were required (I had one system ☹️)
2. Running terraform in my machine (Nahhh!! I really dont wanted to do that)

#### Solutions
`Docker is always our best friend ❣️`
Please find the commands to use single image and create multiple instances of the similar image for multiple use cases (I will try to find a better existing with does this or will create one if I explore more on this)

#### To create terraform image

```sh
docker pull ubuntu

# add a volume to create your terraform files
docker run --name terraform -v $(pwd)/terraform:/terraform -it ubuntu /bin/bash

# install terraform (run these commands one by one in your container)
apt-get update && apt-get install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -

apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

apt-get update && apt-get install terraform

# verify installation
terraform -help

# get your current container id (do it from new terminal session, don't exit from existing one)
docker ps

# commit your container, so that it creates a image in your local docker repo
docker commit <container id> ubuntu/terraform

# to create a new instance (add terraform files in host machine)
docker run --name test-terraform -it ubuntu/terraform /bin/bash
```

#### To create AWS cli image
```sh
docker pull ubuntu

# install required packages (please run these commands one at a time)
apt-get update

apt-get install curl

apt-get install unzip

apt-get install less

# download aws cli package
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# unzip the cli
unzip awscliv2.zip

# install the cli
./aws/install

# verify your installation
aws --version

# get your current container id (do it from new terminal session, don't exit from existing one)
docker ps

# commit your container, so that it creates a image in your local docker repo
docker commit <container id> ubuntu/awscli

# to create a new instance (add terraform files in host machine)
docker run --name test-user -it ubuntu/awscli /bin/bash
```