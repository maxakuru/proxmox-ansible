resource "proxmox_lxc" "readarr" {
  target_node     = "pve"
  hostname        = "readarr"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.readarr_lxcid
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

  // use hdd scratch because it requires mmap
  mountpoint {
    mp      = "/mnt/appdata/readarr"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/pve/safe/appdata/readarr"
    volume  = "/mnt/pve/safe/appdata/readarr"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.readarr_ip
    ip6    = "auto"
    hwaddr = var.readarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}