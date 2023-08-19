/**
 * Static ips
 */

// ---- before DHCP range (<100) ----

// network
# gw -> 192.168.1.1/24
# ap1 -> 192.168.1.2/24
# ap2 -> 192.168.1.3/24

// ---- 10 ----

# variable "samba_ip" {
#   type    = string
#   default = "192.168.1.10/24"
# }

variable "plex_ip" {
  type    = string
  default = "192.168.1.11/24"
}

variable "radarr_ip" {
  type    = string
  default = "192.168.1.12/24"
}

variable "sonarr_ip" {
  type    = string
  default = "192.168.1.13/24"
}

variable "lidarr_ip" {
  type    = string
  default = "192.168.1.14/24"
}

variable "readarr_ip" {
  type    = string
  default = "192.168.1.15/24"
}

variable "prowlarr_ip" {
  type    = string
  default = "192.168.1.16/24"
}

variable "overseerr_ip" {
  type    = string
  default = "192.168.1.17/24"
}

variable "bazarr_ip" {
  type    = string
  default = "192.168.1.18/24"
}

variable "tdarr_ip" {
  type    = string
  default = "192.168.1.19/24"
}

// ---- 20 ----

variable "dash_ip" {
  type    = string
  default = "192.168.1.20/24"
}

variable "nextcloud_ip" {
  type    = string
  default = "192.168.1.21/24"
}

variable "vaultwarden_ip" {
  type    = string
  default = "192.168.1.22/24"
}

variable "nzbget_ip" {
  type    = string
  default = "192.168.1.23/24"
}

variable "deluge_ip" {
  type    = string
  default = "192.168.1.24/24"
}

variable "plexmetamanager_ip" {
  type    = string
  default = "192.168.1.25/24"
}

variable "wireguard_ip" {
  type    = string
  default = "192.168.1.26/24"
}

variable "omada_ip" {
  type    = string
  default = "192.168.1.27/24"
}

variable "radarr_4k_ip" {
  type    = string
  default = "192.168.1.28/24"
}

variable "fabric_ip" {
  type    = string
  default = "192.168.1.29/24"
}

// ---- 80 ----

// smarthome

# variable "homeassistant_ip" {
#   type    = string
#   default = "192.168.1.80/24"
# }

variable "pihole_ip" {
  type    = string
  default = "192.168.1.81/24"
}

# right orb (hackbulb) -> 192.168.1.82
# bed tower (yeelight) -> 192.168.1.83
# other? not used (yeelight) -> 192.168.1.84

// ---- after DHCP range (>220) ----

// devices
# hyper -> 192.168.223/24

// ---- 220 ----

// ---- 230 ----

# maxcloud-mac -> 192.168.230/24
# maxcloud-win -> 192.168.1.231/24
# printer -> 192.168.1.232/24
# maxbook -> 192.168.1.233/24
# maxphone -> 192.168.1.234/24
# maxbook-adobe -> 192.168.1.235/24

// ---- 240 ----

// tools
# terraform -> 192.168.1.240/24
# ansible -> 192.168.1.241/24

// ---- 250 ----

// public 
variable "traefik_ip" {
  type    = string
  default = "192.168.1.250/24"
}

variable "traefik_dmz_ip" {
  type    = string
  default = "10.10.1.250/24"
}

variable "overseerr_dmz_ip" {
  type    = string
  default = "10.10.1.17/24"
}
