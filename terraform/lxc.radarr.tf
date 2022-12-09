resource "proxmox_lxc" "radarr" {
  target_node     = "pve"
  hostname        = "radarr"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.radarr_lxcid
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
    mp      = "/mnt/appdata/radarr"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/pve/safe/appdata/radarr"
    volume  = "/mnt/pve/safe/appdata/radarr"
  }

  mountpoint {
    mp      = "/mnt/storage/media/movies"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/media/movies"
    volume  = "/mnt/big/media/movies"
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
    ip     = var.radarr_ip
    ip6    = "auto"
    hwaddr = var.radarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
      mountpoint[2].storage,
    ]
  }
}