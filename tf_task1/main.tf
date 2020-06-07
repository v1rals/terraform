provider "docker" {

  host = "tcp://127.0.0.1:2376"

}



resource "docker_image" "nginx" {

  name = var.nginx_version

}



resource "docker_image" "php-fpm" {

  name = var.phpfpm_version

}



resource "docker_container" "nginx-srv" {

  image = docker_image.nginx.latest

  name  = "nginx-server"

  ports {

    internal = 80

    external = 8080

    ip = "172.17.0.1"

  }

  networks_advanced {

    name    = docker_network.hw_network.name

  }

  upload {

    content = file("files/default.conf")

    file = "/etc/nginx/conf.d/default.conf"

  }

  depends_on = [docker_container.php-fpm-srv]

}



resource "docker_container" "php-fpm-srv" {

  image = docker_image.php-fpm.latest

  name  = "hw.epam"

  hostname = "hw.epam"

  networks_advanced {

    name    = docker_network.hw_network.name

  }

  upload {

    content = file("files/index.php")

    file = "/var/www/html/index.php"

  }

}



resource "docker_network" "hw_network" {

  name = var.network_name

}
