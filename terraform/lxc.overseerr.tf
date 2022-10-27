resource "proxmox_lxc" "overseerr" {
  target_node     = "pve"
  hostname        = "overseerr"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.overseerr_lxcid
  memory          = 8192
  swap            = 512
  cores           = 2
  password        = var.temp_root_password
  clone           = var.base_lxcid // gives lxc.idmap needed for mounts

  features {
    nesting = true
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "8G"
  }

  mountpoint {
    mp      = "/mnt/appdata/overseerr"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/pve/safe/appdata/overseerr"
    volume  = "/mnt/pve/safe/appdata/overseerr"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.overseerr_ip
    ip6    = "auto"
    hwaddr = var.overseerr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}