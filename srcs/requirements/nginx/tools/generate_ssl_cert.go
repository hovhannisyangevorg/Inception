package main

import (
	"fmt"
	// "log"
	"os"
	"os/exec"
)

func generateSSLcart() {
	pathCerts 			:= os.Getenv("PATH_CERTS")
	pathPrivateKey 		:= os.Getenv("PATH_PRIVATE_KEY")
	country 			:= os.Getenv("COUNTRY")
	location 			:= os.Getenv("LOCATION")
	organization 		:= os.Getenv("ORGANIZATION")
	organizationUnit	:= os.Getenv("ORGANIZATION_UINT")
	commonName 			:= os.Getenv("COMMON_NAME")
	days 				:= "365"

	cmd := exec.Command("openssl", "req", "-x509", "-nodes", "-days", days, "-newkey", "rsa:2048", "-keyout", pathPrivateKey, "-out", pathCerts, "-subj", fmt.Sprintf("/C=%s/L=%s/O=%s/OU=%s/CN=%s", country, location, organization, organizationUnit, commonName))
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		fmt.Fprintf(cmd.Stderr , "%s\n", err)
		os.Exit(1)
	}
}

func execCommand(cmd *exec.Cmd) {
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr

    if err := cmd.Run(); err != nil {
        fmt.Fprintf(os.Stderr, "%s\n", err)
        os.Exit(1)
    }
}

func main() {
	// dirPath := "/etc/nginx/sites-available/"
    // domainName := os.Getenv("COMMON_NAME")
    // pathCerts := os.Getenv("PATH_CERTS")
    // pathPrivateKey := os.Getenv("PATH_PRIVATE_KEY")

	generateSSLcart()
	
	// err := os.Chdir(dirPath)
	// if err != nil {
	// 	fmt.Fprintf(os.Stderr, "%s\n", err)
    //     os.Exit(1)
	// }
	// if _, err := os.Stat("./default.conf"); err == nil {
	// 	execCommand(exec.Command("sed", "-i", fmt.Sprintf("s#\\$DOMAIN_NAME#%s#g", domainName), "default.conf"))
	// 	execCommand(exec.Command("sed", "-i", fmt.Sprintf("s#\\$PATH_CERTS#%s#g", pathCerts), "default.conf"))
	// 	execCommand(exec.Command("sed", "-i", fmt.Sprintf("s#\\$PATH_PRIVATE_KEY#%s#g", pathPrivateKey), "default.conf"))
	// }
	// cmd := exec.Command("cat", "default.conf", ">", "default")
	// cmd.Stdout = os.Stdout
    // cmd.Stderr = os.Stderr
	// if err := cmd.Run(); err != nil {
    //     fmt.Fprintf(os.Stderr, "%s\n", err)
    //     os.Exit(1)
    // }

	// cmd = exec.Command("rm", "-rf", "default.conf")
	// cmd.Stdout = os.Stdout
    // cmd.Stderr = os.Stderr
	// if err := cmd.Run(); err != nil {
    //     fmt.Fprintf(os.Stderr, "%s\n", err)
    //     os.Exit(1)
    // }
	
	// cmd = exec.Command("nginx", "-g", "daemon off;")
	// cmd.Stdout = os.Stdout
    // cmd.Stderr = os.Stderr
	// if err := cmd.Run(); err != nil {
    //     fmt.Fprintf(os.Stderr, "%s\n", err)
    //     os.Exit(1)
    // }
}


