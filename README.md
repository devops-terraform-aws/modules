## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_key"></a> [aws\_key](#module\_aws\_key) | ./parent-module/ssh-key | n/a |
| <a name="module_jenkins"></a> [jenkins](#module\_jenkins) | ./parent-module/ec2-instance | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./parent-module/security-group | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.generated_key](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | n/a | `string` | n/a | yes |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | n/a | `list(string)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Enter the name of your key on aws | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
