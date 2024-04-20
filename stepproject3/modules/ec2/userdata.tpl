#cloud-config
#fqdn: ${hostname}
users:
  - name: alex
    ssh-authorized-keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCd0DKlVh7umU98abmDhGqyNqqggVoIPocd9VG5NZgIIoPafv7DNAHp/4pwqKgx58YVv7gz+5wZaU4z6YhRqyXcsK7bbgSHPPVTMwxbZrqoN0NUGimstaVzTI9Wyzeammcn5/6IREjFQ1fRDr247Jwptl3Bs0Tb9aGv/3orAfnsoR6wEDU4h3Ddu0gZ5YyI4KKGsxoFJ3u9jsZ6Djnv+Gz6MBq0rEye/jTAO0BeKSHEKxCi2ZOFmRPGnQPpMbI+wiQ1ScbUfsi+/AL2CXgXT/9T0/T0ug38fROcu+IsdnNqDNbu0mY9j/5bdulx9A+vpfr2zTVKQm411nb7mOxBjowklYz7GVkg8e8zFQe+5NRKtK8EJDSIUJ31bXCqa//zQzYdBFXRPsfmsQ2pUE3IrFdFgpU6w6rfgyNGedKyLbcD8+Hek048zT7XoTkEpSN4bhXQgPeSnFfxvzlLjeUZhmbsFOH+lr5zwANBnOyriNrRA4jSZmuSvLy+AsaeYYPVMIGxdO0GAVbFjZFBrHX0wEOsl9ZW2AZg5o9bdyJwh4O0gWH8bso90Ex/mOIpyt8emaCeem1c+Z9If1s7jRvvUp5c5pTiwfjVdk3QECW2fH++ec35r7kORyfkPmbRUT3e4fvryu4lyPWvQfa8LiIxpr8ZV4o/kH++LxK4SGSLn2rV2w== buxenko2201@gmail.com
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    groups: sudo
    shell: /bin/bash

write_files:
  - path: /etc/ssh/sshd_config
    content: |
      Port ${ssh_listen_port}
      Protocol 2
      HostKey /etc/ssh/ssh_host_rsa_key
      HostKey /etc/ssh/ssh_host_dsa_key
      HostKey /etc/ssh/ssh_host_ecdsa_key
      HostKey /etc/ssh/ssh_host_ed25519_key
      UsePrivilegeSeparation yes
      KeyRegenerationInterval 3600
      ClientAliveInterval 120
      ServerKeyBits 1024
      SyslogFacility AUTH
      LogLevel INFO
      LoginGraceTime 120
      PermitRootLogin no
      StrictModes yes
      RSAAuthentication yes
      PubkeyAuthentication yes
      IgnoreRhosts yes
      RhostsRSAAuthentication no
      HostbasedAuthentication no
      PermitEmptyPasswords no
      ChallengeResponseAuthentication no
      MACs hmac-sha1,hmac-sha2-256,hmac-sha2-512
      X11Forwarding no
      X11DisplayOffset 10
      PrintMotd no
      PrintLastLog yes
      TCPKeepAlive yes
      AcceptEnv LANG LC_*
      Subsystem sftp /usr/lib/openssh/sftp-server
      UsePAM yes

runcmd:
  - systemctl restart ssh
  - usermod -aG docker alex


package_update: true
package_upgrade: true
packages:
  - docker.io
  - docker-compose
