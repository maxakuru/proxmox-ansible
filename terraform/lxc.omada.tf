resource "proxmox_lxc" "omada" {
  target_node     = "pve"
  hostname        = "omada"
  ostemplate      = "local:vztmpl/debian-11-standard_11.3-1_amd64.tar.zst"
  unprivileged    = true
  start           = true
  onboot          = true
  vmid            = var.omada_lxcid
  memory          = 4096
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
    mp      = "/opt/tplink/EAPController/work"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/big/appdata/omada/work"
    volume  = "/mnt/big/appdata/omada/work"
  }

  mountpoint {
    mp      = "/opt/tplink/EAPController/logs"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/big/appdata/omada/logs"
    volume  = "/mnt/big/appdata/omada/logs"
  }

  // use hdd scratch for mongodb data
  mountpoint {
    mp      = "/opt/tplink/EAPController/data"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/pve/safe/appdata/omada/data"
    volume  = "/mnt/pve/safe/appdata/omada/data"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.omada_ip
    ip6    = "auto"
    hwaddr = var.omada_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
      mountpoint[2].storage,
    ]
  }
}