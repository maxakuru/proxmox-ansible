resource "proxmox_lxc" "radarr-4k" {
  target_node     = "pve"
  hostname        = "radarr-4k"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.radarr_4k_lxcid
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
    mp      = "/mnt/appdata/radarr-4k"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/pve/safe/appdata/radarr-4k"
    volume  = "/mnt/pve/safe/appdata/radarr-4k"
  }

  mountpoint {
    mp      = "/mnt/storage/media/movies-4k"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/media/movies-4k"
    volume  = "/mnt/big/media/movies-4k"
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
    ip     = var.radarr_4k_ip
    ip6    = "auto"
    hwaddr = var.radarr_4k_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
      mountpoint[2].storage,
    ]
  }
}