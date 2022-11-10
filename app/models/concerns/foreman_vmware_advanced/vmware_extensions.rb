# frozen_string_literal: true

module ForemanVmwareAdvanced
  module VmwareExtensions
    def parse_args(inp_args)
      args = super(inp_args)

      args[:extra_config] = (args[:extra_config] || {}).merge(
        'bios.bootOrder': 'ethernet0',
        'disk.EnableUUID': 'TRUE',
        'svga.autodetect': 'TRUE'
      )

      args
    end

    def create_vm(args = {})
      vm = super(args)
      return unless vm

      if SETTINGS[:vtpm_add] && vm.firmware == 'efi'
        begin
          spec = {
            deviceChange: [
              {
                operation: :add,
                device: RbVmomi::VIM::VirtualTPM.new(key: -1)
              }
            ]
          }

          client.vm_reconfig_hardware 'instance_uuid' => vm.attributes[:instance_uuid], 'hardware_spec' => spec
        rescue StandardError => e
          logger.error "Failed to add vTPM - #{e.class}: #{e}"
        end
      end

      vm
    end
  end
end
