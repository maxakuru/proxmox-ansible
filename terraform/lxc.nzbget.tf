resource "proxmox_lxc" "nzbget" {
  target_node     = "pve"
  hostname        = "nzbget"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  ssh_public_keys = file(var.pub_ssh_key)
  vmid            = var.nzbget_lxcid
  memory          = 2048
  swap            = 512
  cores           = 2
  password        = var.temp_root_password
  # clone           = var.base_lxcid // lxc.idmap managed manually

  features {
    nesting = true
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/appdata/nzbget"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/nzbget"
    volume  = "/mnt/big/appdata/nzbget"
  }

   mountpoint {
    mp      = "/mnt/storage/downloads/usenet"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/downloads/usenet"
    volume  = "/mnt/big/downloads/usenet"
  }

   mountpoint {
    mp      = "/mnt/storage/media"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/big/media"
    volume  = "/mnt/big/media"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.nzbget_ip
    ip6    = "auto"
    hwaddr = var.nzbget_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
      mountpoint[2].storage
    ]
  }
}