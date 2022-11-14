# frozen_string_literal: true

module ForemanVmwareAdvanced
  module VmwareExtensions
    def parse_args(inp_args)
      args = super(inp_args)

      args[:extra_config] = (args[:extra_config] || {}).merge(SETTINGS[:vmware_advanced]) if SETTINGS[:vmware_advanced]

      args
    end

    def create_vm(args = {})
      vm = super(args)
      return unless vm

      spec = {}
      if vm.firmeware == 'efi'
        if SETTINGS[:vmware_secureboot] && args[:guest_id]&.start_with?('win')
          spec[:bootOptions] = RbVmomi::VIM::VirtualMachineBootOptions.new(efiSecureBootEnabled: true)
        end

        if SETTINGS[:vtpm_add]
          spec[:deviceChange] = [
            {
              operation: :add,
              device: RbVmomi::VIM::VirtualTPM.new(key: -1)
            }
          ]
        end
      end

      return vm if spec.empty?

      begin
        client.vm_reconfig_hardware 'instance_uuid' => vm.attributes[:instance_uuid], 'hardware_spec' => spec
      rescue StandardError => e
        logger.error "Failed to add advanced VMWare options - #{e.class}: #{e}"
      end

      vm
    end
  end
end
