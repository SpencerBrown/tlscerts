# tlscerts - terraform modules to help create TLS certificates and keys for testing MongoDB

These [terraform modules](https://www.terraform.io/docs/language/modules/index.html#published-modules) are useful to create TLS certificates for test purposes. I use them to with MongoDB test setups.

We do **not recommend** using this for production or other environments that have significant security needs. This is **not** a replacement for a commercial, secure certificate authority. In particular, note that the private key for the root CA certificate is stored in plaintext in the `terraform.tfstate` file. 

However, it **is** useful for quick setup of test servers and clients that need test certificates!

## Contents

* root-ca: Create a TLS root CA certificate and private key
* intermediate-ca: Create a TLS intermediate CA certificate and private key
* server: Create a TLS server certificate and private key
* client: Create a TLS client certificate and private key
* self-signed: Create an actual TLS self-signed certificate (not generally used)

## Usual workflow

* [Download and install terraform](https://www.terraform.io/downloads.html) (it's easy)
* Create your terraform configuration file in a directory using these modules (example later)
* Run `terraform init` in that directory to set things up
* Run `terraform apply` in that directory to create your TLS certificates and keys
* Use them to set up your MongoDB test servers or other servers

## Getting started

* Copy `example.tf` into your own directory
* Follow the "usual workflow" above
* Check the `tls-certs` directory for your generated TLS certs and keys
* Modify `example.tf` and run `terraform apply` again to regenerate the certs and keys as needed (only the changed items will be regenerated)

## Variables/options you can set

* See the `variables.tf` file for each module, for example, `server/veriables.tf`. The `description` field tells you what the option is for. 

## Contributing

* Open an issue or a PR! and thanks!