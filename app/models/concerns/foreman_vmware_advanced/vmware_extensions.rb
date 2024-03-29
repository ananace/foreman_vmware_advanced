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
      spec.merge! build_efi_spec(args) if vm.firmware == 'efi'

      return vm if spec.empty?

      begin
        client.vm_reconfig_hardware 'instance_uuid' => vm.attributes[:instance_uuid], 'hardware_spec' => spec
      rescue StandardError => e
        logger.error "Failed to add advanced VMWare options - #{e.class}: #{e}"
      end

      vm
    end

    private

    def build_efi_spec(args)
      spec = {}

      spec[:bootOptions] = RbVmomi::VIM::VirtualMachineBootOptions.new(efiSecureBootEnabled: true) \
        if SETTINGS[:vmware_secureboot] && args[:guest_id]&.start_with?('win')

      if SETTINGS[:vmware_vtpm]
        spec[:deviceChange] = [
          {
            operation: :add,
            device: RbVmomi::VIM::VirtualTPM.new(key: -1)
          }
        ]
      end

      spec
    end
  end
end
