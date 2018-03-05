module ForemanVmwareAdvanced
  module VmwareExtensions
    extend ActiveSupport::Concern

    included do
      alias_method_chain :parse_args, :vmware_advanced
    end

    def parse_args_with_vmware_advanced(inp_args)
      args = parse_args_without_vmware_advanced(inp_args)

      args[:extra_config] = {
        'bios.bootOrder'  => 'ethernet0',
        'svga.autodetect' => 'TRUE'
      }

      if args[:compute_attributes][:guest_id].start_with? 'win'
        args[:extra_config]['disk.enableUUID'] = 'TRUE'
      end

      args
    end
  end
end
