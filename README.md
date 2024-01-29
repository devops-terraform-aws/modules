# Install Jenkins, SonarQube, Nexus, Tomcat on AWS [![Terraform](https://github.com/devops-terraform-aws/modules/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/devops-terraform-aws/modules/actions/workflows/terraform.yml)
### All resources are provisioned on `us-east-1`(update the [tfvars](https://github.com/devops-terraform-aws/modules/blob/main/terraform.tfvars#L2) for your region)
- Clone the repository:
```
git clone https://github.com/devops-terraform-aws/modules.git
```
## Terraform Virtual Environment Configuration (Optional)
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

### Automated Terraform Installation
- Run `install-terraform.sh` and source `venv`
```
./install-terraform.sh 
```
```
source venv/bin/activate
```

### Manual Terraform Installation
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

### Jenkins Credentials
- Default port: `8080`
- SSH into `jenkins` server using the private key that is created
- inside the `jenkins server`, run 
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Nexus Credentials
- `Default port`: 8081 
- `Username`: admin
- `Password`: SSH into `Nexus` server and run
```
sudo cat /opt/sonatype-work/nexus3/admin.password
```

### SonarQube Credentials
- `Default port`: 9000
- `Username`: admin
- `Password`: admin

### Tomcat Server
- `Default port`: 8080

- To destroy all resources, do:
```
terraform destroy --auto-approve
```

- To clean up your environment after `destroying resources` run:
```
./clean.sh
```