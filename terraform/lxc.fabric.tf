resource "proxmox_lxc" "fabric" {
  target_node     = "pve"
  hostname        = "fabric"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.fabric_lxcid
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
    mp      = "/opt/fabric/world"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/fabric/world"
    volume  = "/mnt/big/appdata/fabric/world"
  }

  // use hdd scratch for mods because EasyAuth requires mmap
  mountpoint {
    mp      = "/opt/fabric/mods"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/pve/safe/appdata/fabric/mods"
    volume  = "/mnt/pve/safe/appdata/fabric/mods"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.fabric_ip
    ip6    = "auto"
    hwaddr = var.fabric_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}