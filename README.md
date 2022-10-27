# cloud-orch

### Terraform
`cd terraform`

#### initialize and setup
```sh
terraform init
terraform apply
# or if using clones and resource gets locked, limit parallelism:
terraform apply -parallelism=2
```

#### destroy container
```sh
terraform destroy -target=proxmox_lxc.traefik
```

#### forget container
```sh
terraform state rm 'proxmox_lxc.HOST_NAME'
```

[For more LXC options](https://github.com/Telmate/terraform-provider-proxmox/blob/master/docs/resources/lxc.md)

### Ansible
`cd ansible`

#### run a single playbook
```sh
ansible-playbook ./site.yml
```

#### run all playbooks
```sh
ansible-playbook ./site.yml
```

#### update known hosts
```sh
ssh-keygen -R "traefik.max.local" && \
ssh-keygen -R "plex.max.local"
# etc...
```

#### debug connection to hosts
```sh
ansible -i production.yml -m ping HOST_NAME.max.local -u root -vvvv
```

#### sshd fix for base template
```sh
# /usr/lib/tmpfiles.d/sshd.conf
d /run/sshd 0755 root root
```

#### TODO
- dash
- readarr
- nextcloud
- openvpn/wireguard
- overseerr
- plexmetamanager
- vaultwarden

### Misc

#### get pid of LXCs
```sh
lxc-ls -f -Fname,pid
```

#### access fs of LXC from host
```sh
cd /proc/PID_OF_LXC/root
```