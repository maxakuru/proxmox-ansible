/**
 * LXC ids
 */

 variable "base_lxcid" {
  type    = number
  default = 8010
}

variable "traefik_lxcid" {
  type    = number
  default = 500
}

// the rest map to their ips

// ---- before DHCP range (9>x<100) ----

// ---- 10 ----

# variable "samba_lxcid" {
#   type    = number
#   default = 510
# }

variable "plex_lxcid" {
  type    = number
  default = 511
}

// *arrs
variable "radarr_lxcid" {
  type    = number
  default = 512
}

variable "sonarr_lxcid" {
  type    = number
  default = 513
}

variable "lidarr_lxcid" {
  type    = number
  default = 514
}

variable "readarr_lxcid" {
  type    = number
  default = 515
}

variable "prowlarr_lxcid" {
  type    = number
  default = 516
}

variable "overseerr_lxcid" {
  type    = number
  default = 517
}

variable "bazarr_lxcid" {
  type    = number
  default = 518
}

variable "tdarr_lxcid" {
  type    = number
  default = 519
}

// ---- 20 ----

// services

variable "dash_lxcid" {
  type    = number
  default = 520
}

variable "nextcloud_lxcid" {
  type    = number
  default = 521
}

variable "vaultwarden_lxcid" {
  type    = number
  default = 522
}

variable "nzbget_lxcid" {
  type    = string
  default = 523
}

variable "deluge_lxcid" {
  type    = string
  default = 524
}

variable "plexmetamanager_lxcid" {
  type    = string
  default = 525
}

variable "wireguard_lxcid" {
  type    = string
  default = 526
}

variable "omada_lxcid" {
  type    = string
  default = 527
}

// ---- 80 ----

// smarthome

# variable "homeassistant_lxcid" {
#   type    = number
#   default = 80
# }

# variable "mosquitto_lxcid" {
#   type    = number
#   default = 81
# }

# variable "diyhue_lxcid" {
#   type    = number
#   default = 82
# }