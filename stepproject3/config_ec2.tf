# resource "null_resource" "run_ansible_playbook" {
#   depends_on = [module.step3_ec2, local_file.ansible_inventory]
#   triggers = {
#     always_run = "${timestamp()}"
#   }
#   provisioner "local-exec" {
#     command = "ansible-playbook main_ansible.yml -i inventory"
#   }
# }

