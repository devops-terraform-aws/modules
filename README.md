# Install Jenkins, SonarQube, Nexus, Tomcat on AWS [![Terraform](https://github.com/devops-terraform-aws/modules/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/devops-terraform-aws/modules/actions/workflows/terraform.yml)
- Clone the repository:
```
git clone https://github.com/devops-terraform-aws/modules.git
```
## All resources are provisioned on `us-east-1`(update tfvars for your region)
- Configure virtual environment on `Ubuntu WSL`
```
sudo ln -sf $(which python3) /usr/bin/python && sudo apt install python3-venv -y && sudo apt install unzip -y
```
```
python --version
```
```
python -m venv venv && source venv/bin/activate
```
```
sudo apt install unzip
```

## Automated Terraform Installation
- Run `install-terraform.sh` and source `venv`
```
./install-terraform.sh 
```
```
source venv/bin/activate
```

## Manual Terraform Installation
```
git clone https://github.com/tfutils/tfenv.git venv/.tfenv 
echo 'export PATH="venv/.tfenv/bin:$PATH"' >> venv/bin/activate
echo 'eval "$(tfenv init -)"' >> venv/bin/activate
export PATH="$PATH:$(pwd)/venv/.tfenv/bin"
```
- Install and use `Terraform`
```
tfenv use latest
```
```
source venv/bin/activate
```

## Deploy Application to AWS
Terraform version must be `v1.3.0` and above
```
terraform --version
```
To deploy all the resources set `bootstrap=true` in the `terraform.tfvars`

```
terraform init
```
```
terraform apply --auto-approve
```


- To destroy all resources, do:
```
terraform destroy --auto-approve
```

- To clean up your environment after `destroying resources` run:
```
./clean.sh
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
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
| <a name="module_unique_name"></a> [unique\_name](#module\_unique\_name) | ./parent-module/random | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.copy_file](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.generated_key](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.ssh](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.redhat-linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu-linux-2004](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to the resource. | `string` | n/a | yes |
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
