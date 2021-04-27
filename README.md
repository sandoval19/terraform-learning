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


