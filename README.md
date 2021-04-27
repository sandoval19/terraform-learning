# Terraform Learning

Learning terraform usages to deploy IaC with AWS services

## Terraform concepts


- Provider: plugin that allows to interact with remote systems or cloud platforms. There are different providers, however try to choose the officials in order to avoid difficult situations
- Resource: describes one or more infrastructure objects (virtual networks, compute instances, among others)

## Terraform commands

- terraform init -> Download all the plugins associated to the provider we are using to interact with it. Everytime we add, modify or delete a provider terraform init is required.

- terraform plan -> allows to verify the execution beforehand, it let us know the changes that will be performed, it also shows if there is an error with the terraform files.

- terraform apply -> applies the changes required to reach the desired state of the configuration.

- terraform destroy -> allows to destroy all the resources that are created within the folder. To destroy an specific resource use the flag -target with the name of the resource to be deleted.

    terraform destroy -target <resource_type>.<resource_name>

To delete a the aws ec2 resource named myec2Test run:

    terraform destroy -target aws_instance.myec2Test

## Terraform State Files

Terraform state files store the state of the infrastructure that stated at the files. This file tracks the resources created, modified ot deleted. *Remember to not delete it or manually edit it if there are resources alive*

## Desider and Current State

Terraform's primary function is to create, modify and destroy infrastructure resources to match the desired state described in a Terraform configuration.

The current state is the actual state of the resource that is currently deployed.

Terraform tries to ensure that the deployed infrastructure MACTH on the desired state. If there is a difference between the two, terraform plan presents a description of the necessary changes to achieve the desired state.

This is possible by the terraform state file explained before.

- terraform refresh -> Fech the remote state and compare with the local state, if there are differences, the remote state is updated to the local state.

## Specifying the provider
If no provider is declared durring the terraform initialization, the lates version will be used by default

How to specify the version of the provider:

    >=1.0 Greater than or equal to the version.
    <=1.0 Less than or equal to the version.
    ~>2.0 Any version in the 2.X range
    >=2.10, <=2.30 Any version between 2.10 and 2.30

terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = ~>2.0
        }
    }
}

When changing the version of the provider after doing the terraform init, terraform will re-select the first version defined. To override the version run:

terraform init -upgrade

## Attributes

Terraform allows to output the attribute from a resource as an output value. Output attributes can also be used as an input to other resources that will be created using terraform.

    output "<output_name>" {
        value = <resource>.<resource_identifier>.<attribute>
    }

## Variables

Repeated static values can create more work in the future, to avoid repeating values we can create terraform variables that are set only once and use them in all the files where the value is needed. Variables are defined as follows:

    variable "<variable_name>" {
        default = "<variable_value>"
    }

The variables defined with a default value in the variables.tf file can be also defined by command line when running terraform plan or terraform apply:

    terraform plan -var="<variable_name>=<variable_value>"

When the variable has not a default value, the value will be required a after running terraform plan or apply.

When using different environments is recommended to define the variables in .tfvars files

Variable types allows to add a constraint about the values that the variable can have. For example, to define a variable of type number:

    variable "<variable_name>" {
        type = "number"
    }

The [count](https://www.terraform.io/docs/language/meta-arguments/count.html#basic-syntax) meta-argument accepts a whole number, and creates many instances as the count variable for the resource usaged. Each instance has a distinct infrastructure object associated with it, and each one applies the init, destoy or plan commands

In blocks where count is set, the name of the resources may be different of each other by adding the count.index attribute by instantiating the name of the resource, for example:

resource "<resource_type>" "<resource_name>" {
    name  = "<variable_name>.${count.index}"
    count = 3
    path  = "/system/"
}

Each of the created resources will be named as the variable name followed by the number of the count in each iteration as follows:

    <variable_name>0
    <variable_name>1
    <variable_name>2

The above approach may lead to difficult naming, however it is posible for the resources to be named with specific names we can define a list of values that contains each of the names for the resources, for example:

variable "<variable_name>" {
    type    = list
    default = ["name1", "name2", "name3"] 
}

resource "<resource_type>" "<resource_name>" {
    name  = var.<variable_name>[count.index]
    count = 3
    path  = "/system/"
}


## Local variables

A local value assigns a name to an expression, allowing it to be used multiple times within a module without repeating.

locals {
  common_tags = {
    Owner   = "Devops Team"
    service = "backend"
  }
}

## Terraform Functions
Terraform includes some base functions. It does not support user defined functios.

    function(arg1, arg2)

See [documentation](https://www.terraform.io/docs/language/functions/index.html)


## Data Sources
Data sources allows data to be fetched or computed for use elsewhere in Terraform configuration.

It is defined under the data block read from a specific data source (aws_ami) and export the result under "app_ami"

data "aws_ami" "app_ami" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        value = ["amzn2-ami-hvm*"]
    }
}

resource "aws_instance" "instance-1" {
    ami = data.aws_ami.app_ami.id
    instance_type = "t2.micro"
}

