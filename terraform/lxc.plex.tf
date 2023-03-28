resource "proxmox_lxc" "plex" {
  target_node     = "pve"
  hostname        = "plex"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.plex_lxcid
  memory          = 16384
  swap            = 512
  cores           = 16
  password        = var.temp_root_password
  clone           = var.base_lxcid // gives lxc.idmap needed for mounts

  features {
    nesting = true
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "8G"
  }

  // use scratch hdd disk for appdata to avoid ssd wear
  mountpoint {
    mp      = "/mnt/appdata/plex"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/pve/safe/appdata/plex"
    volume  = "/mnt/pve/safe/appdata/plex"
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
    ip     = var.plex_ip
    ip6    = "auto"
    hwaddr = var.plex_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
    ]
  }
}