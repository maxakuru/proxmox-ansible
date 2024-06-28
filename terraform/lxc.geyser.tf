resource "proxmox_lxc" "geyser" {
  target_node     = "pve"
  hostname        = "geyser"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.geyser_lxcid
  memory          = 8192
  swap            = 512
  cores           = 4
  password        = var.temp_root_password
  clone           = var.base_lxcid // gives lxc.idmap needed for mounts

  features {
    nesting = true
  }

  rootfs {
    storage = "ssd-safe-zfs"
    size    = "4G"
  }

  // world save data
  mountpoint {
    mp      = "/opt/fabric/worlds"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/geyser/worlds"
    volume  = "/mnt/big/appdata/geyser/worlds"
  }

  // use hdd scratch for mods incase another one requires mmap
  mountpoint {
    mp      = "/opt/fabric/mods"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/pve/safe/appdata/geyser/mods"
    volume  = "/mnt/pve/safe/appdata/geyser/mods"
  }

  // use hdd scratch for plugins incase another one requires mmap
  mountpoint {
    mp      = "/opt/fabric/plugins"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/pve/safe/appdata/geyser/plugins"
    volume  = "/mnt/pve/safe/appdata/geyser/plugins"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.geyser_ip
    ip6    = "auto"
    hwaddr = var.geyser_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}