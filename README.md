# Scenario with Nginx and RDS

This terraform template creates the Nginx on debian machine provisioned using terraform and also a RDS.

The state of this execution will be stored in S3 remote bucket.

### Prerequisites

* An AWS account with right authorization to create resources
* S3 Bucket with path to store the state information
* Terraform Binary to execute the templates.
* Provide the variables information is .tfvars file

## Output

Once, the terraform is executed, it will output the ELB dns name. This dns will gove the nginx output.


