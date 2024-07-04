output "webserver_ips" {
  value =[ aws_instance.slaves[0].public_ip, aws_instance.slaves[1].public_ip]
}
output "jenkins" {
  value = aws_instance.jenkins-sonar.public_ip
}
output "monitor" {
  value = aws_instance.monitor.public_ip
}

output "master" {
  value = aws_instance.master.public_ip
}
