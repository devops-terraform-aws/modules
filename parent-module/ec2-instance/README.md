## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AMI to use for the instance. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to the resource. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Specify the region to for resources to be created. | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security groups to associate with. | `list(string)` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to provide when launching the instance. Do not pass gzip-compressed data via this argument. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The public IP address from the EC2 instance. |
| <a name="output_tags"></a> [tags](#output\_tags) | The Names of the EC2 instance |
