resource "proxmox_lxc" "wireguard" {
  target_node     = "pve"
  hostname        = "wireguard"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = false
  vmid            = var.wireguard_lxcid
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
    mp      = "/mnt/appdata/wireguard"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/wireguard"
    volume  = "/mnt/big/appdata/wireguard"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.wireguard_ip
    ip6    = "auto"
    hwaddr = var.wireguard_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}