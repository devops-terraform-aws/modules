ami           = "ami-06640050dc3f556bb"
instance_type = "t2.small"
subnet_id     = "subnet-0cbdf90cbb40c6afe"
region        = "us-east-1"
name          = "server"
from_port     = 8081
to_port       = 8081
protocol      = "tcp"
cidr_blocks   = ["0.0.0.0/0"]