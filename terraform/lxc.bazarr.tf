resource "proxmox_lxc" "bazarr" {
  target_node     = "pve"
  hostname        = "bazarr"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.bazarr_lxcid
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
    mp      = "/mnt/appdata/bazarr"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/bazarr"
    volume  = "/mnt/big/appdata/bazarr"
  }

  mountpoint {
    mp      = "/mnt/storage/media"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/media"
    volume  = "/mnt/big/media"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.bazarr_ip
    ip6    = "auto"
    hwaddr = var.bazarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
    ]
  }
}