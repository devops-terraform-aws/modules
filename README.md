# Install Jenkins, SonarQube, Nexus, Tomcat(DEV, QA, UAT, PROD) on AWS

## All resources are provisioned on `us-east-1` and `AMIs are region specific`
- `Note`: If you choose to use a specific region, use the correct Ubuntu AMI for that region.

- Clone the repository:
```
git clone https://github.com/devops-terraform-aws/modules.git
```
- To test the configuration, ensure terraform is installed on your local machine.
```
terraform --version
```
```
terraform init
```
```
terraform apply --auto-approve
```


- To destroy all resources do:
```
terraform destroy --auto-approve
```

- To clear directory after `destroying resources` run:
```
./clean.sh
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_key"></a> [aws\_key](#module\_aws\_key) | ./parent-module/ssh-key | n/a |
| <a name="module_jenkins"></a> [jenkins](#module\_jenkins) | ./parent-module/ec2-instance | n/a |
| <a name="module_nexus"></a> [nexus](#module\_nexus) | ./parent-module/ec2-instance | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./parent-module/security-group | n/a |
| <a name="module_sonarqube"></a> [sonarqube](#module\_sonarqube) | ./parent-module/ec2-instance | n/a |
| <a name="module_tomcat"></a> [tomcat](#module\_tomcat) | ./parent-module/ec2-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.generated_key](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.ssh](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.redhat-linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu-linux-2004](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | The IPv4 CIDR block for the VPC | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to the resource. | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from\_port and to\_port equal to 0 | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Specify the region to for resources to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_browser"></a> [jenkins\_browser](#output\_jenkins\_browser) | n/a |
| <a name="output_jenkins_ssh"></a> [jenkins\_ssh](#output\_jenkins\_ssh) | n/a |
| <a name="output_nexus_browser"></a> [nexus\_browser](#output\_nexus\_browser) | n/a |
| <a name="output_nexus_ssh"></a> [nexus\_ssh](#output\_nexus\_ssh) | n/a |
| <a name="output_sonarqube_browser"></a> [sonarqube\_browser](#output\_sonarqube\_browser) | n/a |
| <a name="output_sonarqube_ssh"></a> [sonarqube\_ssh](#output\_sonarqube\_ssh) | n/a |
| <a name="output_tomcat_servers"></a> [tomcat\_servers](#output\_tomcat\_servers) | n/a |
