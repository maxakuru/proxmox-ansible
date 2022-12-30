resource "proxmox_lxc" "pihole" {
  target_node     = "pve"
  hostname        = "pihole"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.pihole_lxcid
  memory          = 2048
  swap            = 512
  cores           = 2
  password        = var.temp_root_password
  clone           = var.base_lxcid // gives lxc.idmap needed for mounts

  features {
    nesting = false
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/appdata/pihole"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/pihole"
    volume  = "/mnt/big/appdata/pihole"
  }

  mountpoint {
    mp      = "/var/log/lighttpd"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/appdata/pihole/log/lighttpd"
    volume  = "/mnt/big/appdata/pihole/log/lighttpd"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.pihole_ip
    ip6    = "auto"
    hwaddr = var.pihole_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
    ]
  }
}