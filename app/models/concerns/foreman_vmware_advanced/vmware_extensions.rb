module ForemanVmwareAdvanced
  module VmwareExtensions
    extend ActiveSupport::Concern

    included do
      alias_method_chain :parse_args, :vmware_advanced
    end

    def parse_args_with_vmware_advanced(inp_args)
      args = parse_args_without_vmware_advanced(inp_args)

      args[:extra_config] = (args[:extra_config] || {}).merge(
        'bios.bootOrder'.to_sym  => 'ethernet0',
        'svga.autodetect'.to_sym => 'TRUE'
      )

      if args[:guest_id] &&
         args[:guest_id].start_with?('win')
        args[:extra_config]['disk.EnableUUID'.to_sym] = 'TRUE'
      end

      args
    end
  end
end
