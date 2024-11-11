package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
)

// Constants for OpenSSL command options
const (
	openSSL     = "openssl"
	request     = "req"
	standard    = "-x509"
	nodes       = "-nodes"
	days        = "-days"
	newkey      = "-newkey"
	rsa         = "rsa:2048"
	keyout      = "-keyout"
	out         = "-out"
	subj        = "-subj"
	defaultDays = "365"
)

var (
	pathCerts        string
	pathPrivateKey   string
	country          string
	location         string
	organization     string
	organizationUnit string
	commonName       string
)

func init() {
	pathCerts = os.Getenv("PATH_CERTS")
	pathPrivateKey = os.Getenv("PATH_PRIVATE_KEY")
	country = os.Getenv("COUNTRY")
	location = os.Getenv("LOCATION")
	organization = os.Getenv("ORGANIZATION")
	organizationUnit = os.Getenv("ORGANIZATION_UNIT")
	commonName = os.Getenv("COMMON_NAME")

	// Check for missing environment variables
	if pathCerts == "" || pathPrivateKey == "" || country == "" || location == "" || organization == "" || organizationUnit == "" || commonName == "" {
		log.Fatal("Error: Missing environment variables")
	}
}

// Generates an SSL certificate using OpenSSL
func generateSSLCert() error {
	cmd := exec.Command(openSSL, request, standard, nodes, days, defaultDays, newkey, rsa, keyout, pathPrivateKey, out, pathCerts, subj,
		fmt.Sprintf("/C=%s/L=%s/O=%s/OU=%s/CN=%s", country, location, organization, organizationUnit, commonName))
	return execCommand(cmd)
}

// Executes the given command and handles error output
func execCommand(cmd *exec.Cmd) error {
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		return fmt.Errorf("command execution failed: %w", err)
	}
	return nil
}

func main() {
	if err := generateSSLCert(); err != nil {
		log.Fatal(err)
	}
}
