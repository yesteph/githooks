# Demo project for pre-commit with Terraform

Use pre-commit for basic Infra As Code project with Terraform:
* check documentation for Terraform code
* check syntax and validate Terraform code
* prevent committing secrets and credentials

## Installation
Require Python3, Terraform >= 0.12 and terraform-docs.

Then install pre-commit and detect-secrets:
`pip install pre-commit detect`

Install pre-commit GIT Hook:
`pre-commit install`

## Terraform Doc is up to date

````
cat >modules/ec2/outputs.tf <<'EOF'
output "instance_id" {
  value = aws_instance.demo.id
}
EOF
git add modules/ec2/outputs.tf
git commit -m 'Test documentation'
git diff > patch.diff
cat patch.diff
````

You should see modules/ec2/README.md has been modified.

Then add it to the index and commit:
````
git add modules/ec2/README.md
git commit -m 'Test documentation'
````

## No secrets

````
cat >credentials <<'EOF'
[default]
aws_access_key_id = AKIAXXXXXXXXXXXXXXXQ
aws_secret_access_key = XXXXXXXXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX
EOF
git add credentials
git commit -m 'Test adding creds'
````


The commit must be refused.
You must remove the credentials file from the GIT Tree.
````
git rm -f credentials
````

## Terraform code is well formatted and correct

````
cat >modules/ec2/wrong-code.tf <<'EOF'
resource "aws_instance" "invalid" {
  instance_type = var.instance_type_WHICH_DOES_NOT_EXIST
  ami           = "data.aws_ami.ubuntu.id"
  tags = {
                    Name = var.name
  }
}
EOF
git add modules/ec2/wrong-code.tf
git commit -m 'Test and validate TF code'
````
You should see the commit has been refused due to invalid formatting in Terraform code AND invalid Terraform code.

# Terraform documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

No input.

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
