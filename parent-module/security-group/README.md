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
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks. | `list(string)` | n/a | yes |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | The from port number. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to assign to the resource. | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from\_port and to\_port equal to 0. | `string` | n/a | yes |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | The to port number. | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_id"></a> [security\_id](#output\_security\_id) | The security group id. |
