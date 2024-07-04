import json
import subprocess

# Get Terraform outputs in JSON format
terraform_output = subprocess.check_output(['terraform', 'output', '-json']).decode('utf-8')
terraform_data = json.loads(terraform_output)

# Extract the IPs
webserver_ips = terraform_data['webserver_ips']['value']
monitor = terraform_data['monitor']['value']
jenkins = terraform_data['jenkins']['value']
master = terraform_data['master']['value']

inventory_content = "[slaves]\n"
inventory_content += "\n".join(webserver_ips)
inventory_content+="\n\n[jenkins]"+"\n"+jenkins
inventory_content+="\n\n"+"[monitor]"+"\n"+monitor
inventory_content+="\n\n"+"[master]"+"\n"+master


with open('../ansible/inventory.ini', 'w') as inventory_file:
    inventory_file.write(inventory_content)

print("**************Ansible inventory generated at inventory.ini**************")
