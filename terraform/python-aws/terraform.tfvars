aws_region     = "eu-west-2"
aws_access_key = ""
aws_secret_key = ""

# these are zones and subnets examples
availability_zones = ["eu-west-2a", "eu-west-2b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]

# these are used for tags
app_name        = "aws-learning"
app_environment = "dev"

# the listening port of the container
container_port = 5000

health_start_period = 60