import json
import subprocess

# Get Terraform outputs in JSON format
terraform_output = subprocess.check_output(['terraform', 'output', '-json']).decode('utf-8')
terraform_data = json.loads(terraform_output)

# Extract the IPs
webserver_ips = terraform_data['webserver_ips']['value']
db_server_ip = terraform_data['db_ip']['value']
monitor = terraform_data['monitor']['value']
jenkins = terraform_data['jenkins']['value']

inventory_content = "[webservers]\n"
inventory_content += "\n".join(webserver_ips)
inventory_content += "\n\n[db]\n"
inventory_content += db_server_ip + "\n\n"
inventory_content+="[jenkins]"+"\n"+jenkins
inventory_content+="\n\n"+"[monitor]"+"\n"+monitor


with open('../ansible/inventory.ini', 'w') as inventory_file:
    inventory_file.write(inventory_content)

print("**************Ansible inventory generated at inventory.ini**************")