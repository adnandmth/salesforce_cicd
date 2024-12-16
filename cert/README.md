# Steps taken to generate certifications

## source https://www.youtube.com/watch?v=dA9OFTciAQk
### Connected App = CI/CD Deployment App

```bash
openssl genrsa -des3 -passout pass:{} -out server.pass.key 2048
```

## Explanation:
    • openssl genrsa: Generates a new RSA private key.
	• -des3: Encrypts the private key with Triple DES for additional security.
	• -passout pass:{}: Sets the password for encrypting the key.
	• -out server.pass.key: Specifies the output filename as server.pass.key.
	• 2048: Specifies the key length (2048 bits), which is a common secure key length.

```bash
openssl rsa -passin pass:{} -in server.pass.key -out server.key
```

## Explanation:

	•	openssl rsa: Uses OpenSSL’s rsa command to process an RSA key.
	•	-passin pass:BIaccess2024: Supplies the password (BIaccess2024) required to read the encrypted input key.
	•	-in server.pass.key: Specifies the input file, server.pass.key, which is the encrypted RSA private key.
	•	-out server.key: Specifies the output file, server.key, which will contain the unencrypted private key.

Purpose:

This command decrypts server.pass.key (the password-protected private key) and writes an unencrypted version to server.key. The resulting server.key can then be used in environments (like CI/CD) that do not support interactive password prompts.

```bash
openssl req -new -key server.key -out server.csr
```
## Explanation:

	•	openssl req: Initiates a certificate request using OpenSSL.
	•	-new: Specifies that a new CSR should be created.
	•	-key server.key: Uses the private key server.key (which should be unencrypted) to sign the CSR.
	•	-out server.csr: Specifies the output filename for the CSR, server.csr.

Purpose:

This command creates a CSR file (server.csr) that you can submit to a Certificate Authority (CA) to request an SSL/TLS certificate. The CSR includes information about your organization and public key, and the CA uses this information to generate a certificate that can be used to authenticate and secure connections.

During the process, you’ll be prompted to enter details about your organization, like country, state, common name (domain name), etc., which will be embedded in the CSR.

```bash
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
```

## Explanation:

	•	openssl x509: Invokes the x509 command in OpenSSL, which is used for certificate-related operations.
	•	-req: Specifies that the input is a CSR (certificate signing request).
	•	-sha256: Uses SHA-256 as the hashing algorithm for the certificate signature.
	•	-days 365: Sets the validity of the certificate to 365 days (1 year).
	•	-in server.csr: Specifies server.csr as the input CSR file.
	•	-signkey server.key: Uses server.key (the private key) to sign the certificate.
	•	-out server.crt: Specifies server.crt as the output file for the generated certificate.

Purpose:

This command creates a self-signed certificate (server.crt) valid for 365 days, using server.csr and signing it with server.key. Self-signed certificates are commonly used for development and testing environments where a trusted Certificate Authority (CA) isn’t required.

```bash
sfdx auth:jwt:grant --client-id {} -f cert/server.key ---username {} -a prod -r https://lamudi.my.salesforce.com --json

```