## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Resources

| Name | Type |
|------|------|
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AMI to use for the instance. | `string` | `null` | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance. | `string` | `null` | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key name of the Key Pair to use for the instance. | `string` | `null` | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to the resource. | `string` | `null` | yes |
| <a name="input_region"></a> [region](#input\_region) | Specify the region to for resources to be created. | `string` | `null` | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | VPC Subnet ID to launch in. | `string` | `null` | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to provide when launching the instance. Do not pass gzip-compressed data via this argument. | `string` | `null` | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security group IDs to associate with. | `list(string)` | <pre>[null]</pre> | yes |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks. | `list(string)` | <pre>[null]</pre> | yes |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | The from port number. | `number` | `null` | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from\_port and to\_port equal to 0. | `string` | `null` | yes |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | The to port number. | `number` | `null` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The public IP address from the EC2 instance. |
| <a name="output_security_id"></a> [security\_id](#output\_security\_id) | The security group id. |
