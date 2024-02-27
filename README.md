# Install Jenkins, SonarQube, Nexus, Tomcat on AWS [![Terraform](https://github.com/devops-terraform-aws/modules/actions/workflows/terraform.yml/badge.svg?branch=main)](https://github.com/devops-terraform-aws/modules/actions/workflows/terraform.yml)
### All resources are provisioned on `us-east-1`(update the [tfvars](https://github.com/devops-terraform-aws/modules/blob/main/terraform.tfvars#L2) for your region)
- Clone the repository:
```
git clone https://github.com/devops-terraform-aws/modules.git
```
## Terraform Virtual Environment Configuration - WSL-Ubuntu (Optional)
- Configure virtual environment on `Ubuntu WSL`

```
sudo apt update && sudo apt upgrade -y
sudo ln -sf $(which python3) /usr/bin/python && sudo apt install python3-venv -y && sudo apt install unzip -y
```

```
python -m venv venv && source venv/bin/activate
```

- Terraform Installation
    - Run the `install-terraform.sh` script
    ```
    ./scripts/install-terraform.sh 
    ```
    - Reload the virtual environment to ensure you have the latest terraform version
    ```
    source venv/bin/activate
    ```


## Deploy Application to AWS
- Terraform version must be `v1.3.0` and above. verify your installations by running
```
terraform --version
```

### AWS Credentials Setup (Optional)
    ```
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    ```
    ```
    unzip awscliv2.zip
    ```
    ```
    sudo ./aws/install
    ```
    ```
    aws --version
    ```

- Generate `Access Key` and `Secret Keys` from AWS [Click Here](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-2#/security_credentials)
    - In `WSL2`, do:
        ```
        aws configure
        ```
    - Parse the following: <br />
        `AWS Access Key ID [None]: `<br /> `AWS Secret Access Key [None]: `<br /> `Default region name [None]: ` <br /> `Default output format [None]: `
- To deploy all the resources set `bootstrap=true` in the `terraform.tfvars`

```
terraform init && terraform apply --auto-approve
```
- Give it 1 minute to provision the server(s).

### Jenkins Credentials
- `Default port`: 8080
- `SSH` into `Jenkins Server` using the private key that is created
- Inside the `Jenkins Server`, run 
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Nexus Credentials
- `Default port`: 8081 
- `Username`: admin
- `Password`: `SSH` into `Nexus Server` and run
```
sudo cat /opt/sonatype-work/nexus3/admin.password
```

### SonarQube Credentials
- `Default port`: 9000
- `Username`: admin
- `Password`: admin

### Tomcat Server
- `Default port`: 8080

## To Provision Specific Server
- Configure the [tfvars](https://github.com/devops-terraform-aws/modules/blob/main/terraform.tfvars#L3-#L8)
- For example to provision only `Jenkins Server`, set <br>
```
bootstrap_jenkins   = true
bootstrap_tomcat    = false
bootstrap_nexus     = false
bootstrap_sonarqube = false
```

- To whitelist on your IP (Allow only your IP to access the VMs), set `allow_all_network_traffic` to `false` in the [tfvars | Line 9](https://github.com/devops-terraform-aws/modules/blob/main/terraform.tfvars#L9)
    ```
    allow_all_network_traffic = false
    ```

- I have set all `bootstrap` servers to `true`

## Destroy all resources
```
terraform destroy --auto-approve
```

- To clean up your environment after `destroying resources` run:
```
./scripts/clean.sh
```
