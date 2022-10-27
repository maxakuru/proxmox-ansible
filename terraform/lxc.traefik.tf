resource "proxmox_lxc" "traefik" {
  target_node     = "pve"
  hostname        = "traefik"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  ssh_public_keys = file(var.pub_ssh_key)
  vmid            = var.traefik_lxcid
  memory          = 2048
  swap            = 512
  cores           = 2
  password        = var.temp_root_password
  # clone           = var.base_lxcid // lxc.idmap managed manually

  features {
    nesting = true
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/appdata/traefik"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/traefik"
    volume  = "/mnt/big/appdata/traefik"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.traefik_ip
    ip6    = "auto"
    hwaddr = var.traefik_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}