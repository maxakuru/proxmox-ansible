variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type        = string
  default     = "https://pve.max.local:8006/api2/json"
}
  
variable "proxmox_user" {
  description = "The Proxmox user"
  type        = string
  default     = "root@pam"
}

variable "proxmox_password" {
  description = "The Proxmox user password"
  type        = string
  sensitive   = true
}

variable "pub_ssh_key" {
  description = "Public SSH key for passwordless login/Ansible admining"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "gateway_ip" {
  description = "LXC gateway IP"
  type        = string
  default     = "192.168.1.1"
}

variable "temp_root_password" {
  description = "The temporary root password"
  type        = string
  sensitive   = true
}