resource "proxmox_lxc" "dash" {
  target_node     = "pve"
  hostname        = "dash"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = false
  vmid            = var.dash_lxcid
  memory          = 2048
  swap            = 512
  cores           = 2
  password        = var.temp_root_password
  clone           = var.base_lxcid // gives lxc.idmap needed for mounts

  features {
    nesting = true
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/appdata/dash"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/dash"
    volume  = "/mnt/big/appdata/dash"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.dash_ip
    ip6    = "auto"
    hwaddr = var.dash_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}