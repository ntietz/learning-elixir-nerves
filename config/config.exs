# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

# config :nerves, :firmware,
#   rootfs_overlay: "rootfs_overlay",
#   fwup_conf: "config/fwup.conf"

# Use bootloader to start the main application. See the bootloader
# docs for separating out critical OTP applications such as those
# involved with firmware updates.
config :bootloader,
  init: [:nerves_runtime, :nerves_network],
  app: :hello_nerves

config :hello_nerves, interface: :wlan0

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ],
  eth0: [
    ipv4_address_method: :dhcp
  ]

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay"

config :nerves_firmware_ssh,
  authorized_keys: [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDyMDgTPGTVU9AU7QafpNGuB+hiklZD2TiS3hTw8KnotaM15eJVL5WSHE5wPJkEzSGkyiOHfQHMwYPkMRTT63yyDQU19TvJqw1IHsiiu+ErkoKibFepxSnY9yU01RfJdZF7UyMbn7cgbCTUNgDHSqLaytTAf1kpeyqaSmv+QznuJDC0MLp07CMFVQgLw2F3IJwCvWeYbMQKCp1ihYsSqQl9znrDUAAflOWlV6R+HM/vCwVF7TlWGtFjgn6QSdCIk6L0ld7GqLFUaKHRncqxjbRB79mPZdmsWK8HdB1UtmlDP4K45RWELd/2Gw7PXaneYWN03tfRn19dSHPzlDSZardb nicholas@macchiato"
  ]

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
