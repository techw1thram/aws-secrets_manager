
Terraform module to support creating secret values within secret to prevent access issues for dcDeveloper role

## Usage

You can create secret values for plain texts and keys/value pairs. 

```
module "data-platform-example-secrets" {

  source = "dp-aws-secrets-manager"

  secrets = {
    secret-plain = {
      description             = "My plain text secret"
      secret_string           = "This is an example"
    },
    secret-key-value = {
      description = "This is a key/value secret"
      secret_key_value = {
        username = "user"
        password = "topsecret"
      }
    },
  }

  tags = {
    Environment = "dev"
    Terraform   = true
  }

}
```
