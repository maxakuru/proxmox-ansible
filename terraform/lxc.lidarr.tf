resource "proxmox_lxc" "lidarr" {
  target_node     = "pve"
  hostname        = "lidarr"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.lidarr_lxcid
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
    mp      = "/mnt/appdata/lidarr"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/pve/safe/appdata/lidarr"
    volume  = "/mnt/pve/safe/appdata/lidarr"
  }

  mountpoint {
    mp      = "/mnt/storage/media/music"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/media/music"
    volume  = "/mnt/big/media/music"
  }

  mountpoint {
    mp      = "/mnt/storage/downloads"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/big/downloads"
    volume  = "/mnt/big/downloads"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.lidarr_ip
    ip6    = "auto"
    hwaddr = var.lidarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
      mountpoint[2].storage,
    ]
  }
}