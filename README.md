# Foreman VMWare Advanced

Adds in support for setting advanced values in the VMWare configuration

This is useful for specifying things like `disk.enableUUID=true` or `svga.autodetect=true`


## Installation

Follow the Foreman manual for [advanced installation from gems](https://theforeman.org/plugins/#2.3AdvancedInstallationfromGems)


## Usage

Create a configuration file in the Foreman config folder - e.g. `/etc/foreman/plugins/foreman_vmware_advanced.yaml`  
In there you can configure any of the values managed by the plugin;

```yaml
---
# Additional VMX options
:vmware_advanced:
  bios.bootOrder: ethernet0,hdd
  disk.EnableUUID: 'TRUE'
  svga.autodetect: 'TRUE'
  tools.upgrade.policy: upgradeAtPowerCycle

# Enable secureboot on new Windows UEFI VMs
:vmware_secureboot: true
# Attach a vTPM to all new VMs
:vmware_vtpm: true
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ananace/foreman_vmware_advanced  
The project lives at https://gitlab.liu.se/ITI/foreman_vmware_advanced


## License

The gem is available as open source under the terms of the [GPL 3.0 License](https://opensource.org/license/gpl-3-0).

