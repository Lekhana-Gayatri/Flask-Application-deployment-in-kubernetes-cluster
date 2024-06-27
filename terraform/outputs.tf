output "webserver_ips" {
  value =[ aws_instance.webserver[0].public_ip, aws_instance.webserver[1].public_ip]
}
output "db_ip" {
  value = aws_instance.db.public_ip
}
output "jenkins" {
  value = aws_instance.jenkins-sonar.public_ip
}
output "monitor" {
  value = aws_instance.jenkins-sonar.public_ip
}