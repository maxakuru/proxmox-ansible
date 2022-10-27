/**
 * mac addrs
 */

variable "traefik_mac" {
    type    = string
    default = "B6:1A:E1:C6:86:03"
}

# variable "samba_mac" {
#     type    = string
#     default = "46:C7:9A:E0:57:CB"
# }

variable "plex_mac" {
    type    = string
    default = "46:C7:F9:07:98:0F"
}

// *arr

variable "radarr_mac" {
  type    = string
  default = "46:C7:05:AE:A4:09"
}

variable "sonarr_mac" {
  type    = string
  default = "46:C7:6E:2E:7E:13"
}

variable "lidarr_mac" {
  type    = string
  default = "46:C7:D5:08:10:36"
}

variable "readarr_mac" {
  type    = string
  default = "46:C7:75:95:D4:CE"
}

variable "prowlarr_mac" {
  type    = string
  default = "46:C7:AA:D3:F7:E8"
}

variable "overseerr_mac" {
  type    = string
  default = "46:C7:B4:65:AF:89"
}

variable "bazarr_mac" {
  type    = string
  default = "46:C7:B4:65:AF:90"
}

variable "tdarr_mac" {
  type    = string
  default = "46:C7:B4:65:AF:91"
}

// services

variable "dash_mac" {
    type    = string
    default = "46:C8:6E:D9:27:75"
}

variable "nextcloud_mac" {
  type    = string
  default = "46:C8:85:D4:C5:03"
}

variable "vaultwarden_mac" {
  type    = string
  default = "46:C8:F9:D1:A5:09"
}

variable "nzbget_mac" {
  type    = string
  default = "46:C8:F9:D1:A5:0A"
}

variable "deluge_mac" {
  type    = string
  default = "46:C8:F9:D1:A5:1A"
}

variable "plexmetamanager_mac" {
  type    = string
  default = "46:C8:F9:D1:A5:1B"
}

variable "wireguard_mac" {
  type    = string
  default = "46:C8:F9:D1:A5:1C"
}

// smarthome

# variable "homeassistant_mac" {
#   type    = string
#   default = "46:C9:FE:07:A1:CF"
# }

# variable "mosquitto_mac" {
#   type    = string
#   default = "46:C9:31:FC:D4:4A"
# }

# variable "diyhue_mac" {
#   type    = string
#   default = "46:C9:77:B4:37:E0"
# }