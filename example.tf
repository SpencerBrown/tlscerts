// The private keys are stored UNENCRYPTED in the Terraform state file, so use this for testing only.

// This example creates a root CA certificate, an intermediate CA certificate, a server certificate, and a client certificate; all with corresponding private keys.
// All files are in PEM format and stored in the "tls-certs" directory

//*************************************************************
// Create the public root Certificate Authority key and cert
// Creates:
// "public-ca.pem" (root CA certificate),
// "public-ca.key" (private key)

module "public-root-ca" {  // create a resource called "public-root-ca"
  source = "github.com/SpencerBrown/tlscerts/root-ca" // access the root-ca module
  prefix = "public-ca" // Specify prefix for created certificate and key files
  subject = {  // The subject distinguished name
    O  = "MongoDB"
    OU = "Public"
    CN = "Root CA"
  }
}
//**************************************************************

//**************************************************************
// Create the public intermediate signing CA certificate and key
// Creates:
// "public-signing-ca.key" (private key),
// "public-signing-ca.pem" (certificate),
// "public-signing-ca-root.pem" (intermediate and root CA certificates together)

module "public-signing-ca" {
  source  = "github.com/SpencerBrown/tlscerts/intermediate-ca"  // Reference the module
  prefix  = "public-signing-ca"  // Prefix for filenames
  ca_cert = module.public-root-ca.cert // root CA certificate that signs this
  ca_key  = module.public-root-ca.key  // root CA private key that signs this
  subject = {  // Subject distinguished name
    O  = "MongoDB"
    OU = "Public"
    CN = "Signing CA"
  }
}
//**************************************************************

//**************************************************************
// Create the Server key and CA-signed certificate
// creates:
// "public-server.key" (private key),
// "public-server.pem" (certificate),
// "public-server-key-cert.pem" (key and certificate in one file)

module "public-server-cert" {
  source  = "github.com/SpencerBrown/tlscerts/server"  // reference the source module
  prefix  = "public-server" // Prefix for filename
  ca_cert = module.public-signing-ca.cert  // CA cert that is signing this
  ca_key  = module.public-signing-ca.key  // CA key that is signing this
  subject = {  // Subject DN
    O  = "MongoDB"
    OU = "Public"
    CN = "Server"
  }
  dns_names = [  // Hostnames that this server certificate is for (aka the SAN list)
    "mongodb-local.computer",
    "repro"
  ]
}
//**************************************************************

//**************************************************************
// Create the Client key and CA-signed cert
// creates:
// "client.key" (private key),
// "client.pem" (certificate),
// "client-key-cert.pem" (key and certificate in one file)

module "client-cert" {
  source  = "github.com/SpencerBrown/tlscerts/client"  // reference the source module
  prefix  = "client"  // Prefix for filenames
  ca_cert = module.public-signing-ca.cert  // CA cert that signs this
  ca_key  = module.public-signing-ca.key   // CA key that signs this
  subject = {  // Subject DN
    O  = "MongoDB"
    OU = "Public-Client"
    CN = "Client"
  }
}
//**************************************************************
