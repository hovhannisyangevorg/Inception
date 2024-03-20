package main

import (
    "os"
)

func main() {
    // Create directory structure
    directories := []string {
        "srcs/requirements/bonus",

		"srcs/requirements/mariadb",
        "srcs/requirements/mariadb/conf",
        "srcs/requirements/mariadb/tools",

		"srcs/requirements/nginx",
        "srcs/requirements/nginx/conf",
        "srcs/requirements/nginx/tools",
	
        "srcs/requirements/wordpress",
		"srcs/requirements/wordpress/conf",
		"srcs/requirements/wordpress/tools",
    }
    for _, dir := range directories {
        os.MkdirAll(dir, 0755)
    }

    // Create files
    files := []string{
        "Makefile",
        "srcs/docker-compose.yml",
        "srcs/.env",

        "srcs/requirements/mariadb/Dockerfile",
        "srcs/requirements/mariadb/.dockerignore",
        "srcs/requirements/mariadb/conf/50-server.cnf",
        "srcs/requirements/mariadb/tools/mariadb-setup.go",

        "srcs/requirements/nginx/Dockerfile",
        "srcs/requirements/nginx/.dockerignore",
		"srcs/requirements/nginx/conf/default.conf",
		"srcs/requirements/nginx/tools/nginx-ssl-setup.go",

		"srcs/requirements/wordpress/Dockerfile",
        "srcs/requirements/wordpress/.dockerignore",
		"srcs/requirements/wordpress/conf/WWW.conf",
		"srcs/requirements/wordpress/tools/wordpress-setup.go",
    }
    for _, file := range files {
        os.Create(file)
    }

    // Set permissions
    os.Chmod("Makefile", 0664)
    os.Chmod("srcs/docker-compose.yml", 0664)
    os.Chmod("srcs/.env", 0664)
    os.Chmod("srcs/requirements/mariadb/Dockerfile", 0664)
    os.Chmod("srcs/requirements/mariadb/.dockerignore", 0664)
    os.Chmod("srcs/requirements/nginx/Dockerfile", 0664)
    os.Chmod("srcs/requirements/nginx/.dockerignore", 0664)

    // Populate srcs/.env
    envFile, err := os.OpenFile("srcs/.env", os.O_APPEND|os.O_WRONLY, 0644)
    if err != nil {
        panic(err)
    }
    defer envFile.Close()

    envFile.WriteString("DOMAIN_NAME=wil.42.fr\n")
    envFile.WriteString("# certificates\n")
    envFile.WriteString("CERTS_=./XXXXXXXXXXXX\n")
    envFile.WriteString("# MYSQL SETUP\n")
    envFile.WriteString("MYSQL_ROOT_PASSWORD=XXXXXXXXXXXX\n")
    envFile.WriteString("MYSQL_USER=XXXXXXXXXXXX\n")
    envFile.WriteString("MYSQL_PASSWORD=XXXXXXXXXXXX\n")

    // Print success message
    println("File hierarchy created successfully.")
}
