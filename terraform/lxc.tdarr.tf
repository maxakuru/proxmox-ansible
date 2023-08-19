resource "proxmox_lxc" "tdarr" {
  target_node     = "pve"
  hostname        = "tdarr"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = false
  vmid            = var.tdarr_lxcid
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
    mp      = "/opt/tdarr/configs"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/tdarr"
    volume  = "/mnt/big/appdata/tdarr"
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
    ip     = var.tdarr_ip
    ip6    = "auto"
    hwaddr = var.tdarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
    ]
  }
}