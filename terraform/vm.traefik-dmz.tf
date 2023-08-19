resource "proxmox_vm_qemu" "traefik-dmz" {
  target_node     = "pve"
  name            = "traefik-dmz"
  iso             = "local:iso/ubuntu-22.04.1-live-server-amd64.iso"
  os_type         = "ubuntu"
  onboot          = true
  vmid            = var.traefik_dmz_vmid
  memory          = 4096
  cores           = 2

  # manually add /root/.ssh/authorized_keys

  disk {
    type = "virtio"
    storage = "local-zfs"
    size = "32G"
  }

  network {
    model     = "virtio"
    bridge    = "vmbr1"
    macaddr   = var.traefik_dmz_mac
    firewall  = true
  }
}