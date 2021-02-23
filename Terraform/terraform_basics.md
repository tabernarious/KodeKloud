# Terraform

## 3 Phases

### Init
* Initializes the project
* Identifies the providers to be used for the target environment

### Plan
* Drafts a plan to get to the target state

### Apply
* Makes the necessary changes required on the target environment to get to the desired state

Subsequent "apply" will bring the environment to the desired state by changing only what is required

## Resources

Every object that Terraform manages is called a `resource`
* Compute instance
* DB server in the cloud
* Physical server on-premises

### Lifecycle
Terraform manages the lifecycle of resources from provisioning to configuration and finally decomissioning.
1. Provisioning
2. Configuration
3. Decommissioning

## State
Terraform records the state of the infrastructure as it is seen in the real world, which it uses to determine any required changes.

Terraform can ensure the infrastructure is in the defined state at all times.

## Import
Read attributes of existing infrastructure components by configurating data sources. This data can be used to feed into provisioning infrastructure.
Import resources outside of Terraform...to manage going forward.

## Terraform Cloud and Terraform Enterprise
Paid services to provide unified interfaces and enterprise-grade infrastructure provisioning tool.

# Workflow
1. Write the configuration file(s).
    1. The following commands will execute *all* `.tf` files in the working directory.
1. Run the `terraform init` command.
    1. Review needed provider plugins (based on configuration).
    1. Installs/updates provider plugins as needed.
        1. Latest version is used, unless specified.
1. Review the execution plan using `terraform plan`.
    1. Displays "diff" format, showing `+` (added) and `-` (removed) elements.
1. Apply the changes using `terraform apply` command.
    1. Executes the adds and removes noted in `terraform plan`.
1. Use `terraform show` to see the details of the resource just created.
1. Destroy the resources using `terraform destroy`.

## HashiCorp Configuration Language

```terraform
<block> <parameters> {
    <arguments>
}

<block name> <provider>_<resource> <resource name> {
    <key1> = <value1>
    <key2> = <value2>
}
```

Create a folder
```
mkdir /root/terraform-local-file
cd /root/terraform-local-file
```

local.tf
```terraform
resource "local_file" "pet" {
    filename = "/root/pets.txt"
    content = "We love pets!"
    file_permission = "0700"
}
```

aws-ec2.tf
```terraform
resource "aws_instance" "webserver" {
    ami = "ami-0c2f25c1f66a1ff4d"
    instance_type = "t2.micro"
}
```

aws-s3.tf
```terraform
resource "aws_s3_bucket" "data" {
    bucket = "webserver-bucket-org-2207"
    acl = "private"
}
```

## Providers

### Format
`hashicorp/local`

`registry.terraform.io/hashicorp/local`

`[hostname]/[organizational namespace]/[type]`
* `[hostname]` defaults to `registry.terraform.io`

### Documentation
https://registry.terraform.io/

https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file#sensitive_content

### Official
* aws
* gcp
* azure
* local

### Verified
* f5
* heroku
* digitalocean

### Community
* activedirectory
* ucloud
* netapp-gcp


## Immutability
When changes are required, Terraform will destroy the old resource and create a new one.

## File Structure

Typically:

* `main.tf` (resource definitions)
* `variables.tf` (variable declarations)
* `outputs.tf` (outputs from resources)
* `provider.tf` (provider definitions)


## Variables

`string` (a string)
```terraform
variable test_string {
    default     = "This is my string!"
    type        = string
    description = "A test string"
}
```

`number` (integer? float?)
```terraform
variable pet_name_length {
    default     = "2"
    type        = number
    description = "Length of pet name"
}
```

`bool` (`true` or `false`)
```terraform
variable password_change {
    default     = "true"
    type        = bool
    description = "Does the password need to change?"
}
```

`any` (auto-determined)
```terraform
variable something {
    default     = "true"
    type        = any
    description = "Does the password need to change?"
}
```

`list` 

```terraform
# Auto-detected (any) list type
variable "name_prefix" {
    default = ["Mr", "Mrs", "Sir"]
    type    = list
}

resource "random_pet" "my-pet" {
    prefix = var.name_prefix[0]
}

# String list type (will error if not strings).
)
variable "name_prefix" {
    default = ["Mr", "Mrs", "Sir"]
    type    = list(string)
}

# Number list type (will error if not numbers)
variable "number_list" {
    default = ["1", "2", "3"]
    type    = list(number)
}
```

`map` (key1=value1, key2=value2)
```
variable file-content {
    type    = map
    default = {
        "statement1" = "We love pets!"
        "statement2" = "We love animals!"
    }
}

resource local_file my-pet {
    filename = "/root/pets.txt"
    content  = var.file-content["statement2"]
}
```
`set` (list but will error if duplicates exist)

`object` (complex data structure)
```terraform
variable "bella" {
    type = object({
        name         = string
        color        = string
        age          = number
        food         = list(string)
        favorite_pet = bool
    })

    default = {
        name         = "bella"
        color        = "brown"
        age          = 7
        food         = ["fish", "chicken", "turkey"]
        favorite_pet = true
    }
}
```

`tuple` (list of defined length but supports different types; will error on mismatched value/type)

```terraform
variable kitty {
    type    = tuple([string, number, bool])
    default = ["cat", 7, true]
}
```

## Ways to Define Variables

### Assign the `default` value.
```
variable testvar1 {
    default     = "This is testvar1!"
    type        = string
    description = "A test string"
}
```

### Enter interactively during `terraform apply` by not defining a default value.
```
variable testvar1 {
    type        = string
    description = "A test string"
}
```
```
var.testvar1
  Enter a value: This is testvar1!
```

### Entering in-line with `terraform apply` and the `-var` option.
`terraform apply -var "testvar1=This is testvar1!" -var "testvar2=Another testvar"`

### Setting Environment Variables prefixed with `TF_VAR_`
```sh
$ export TF_VAR_testvar1="This is testvar1!"
$ export TF_VAR_testvar2="Another testvar"
```

### Auto-Loaded Variable Definition Files
These filenames will be auto-loaded when running `terraform apply`:
* `terraform.tfvars`
* `terraform.tfvars.json`
* `*.auto.tfvars`
* `*.auto.tfvars.json`

`terraform.tfvars` (auto-loaded)
```
testvar1="This is testvar1!"
testvar2="Another testvar"
```

### Manually-Specified Variable Definition Files
Any variable definition file not auto-loaded (see other section), must be specified with the `-var-file` option

`variables.tfvars` (not auto-loaded)
