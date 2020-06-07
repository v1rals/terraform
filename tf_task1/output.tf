output "url" {

  value= join("",["http://",docker_container.nginx-srv.ports[0].ip,":",docker_container.nginx-srv.ports[0].external])

}
