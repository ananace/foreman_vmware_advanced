# frozen_string_literal: true

module ForemanVmwareAdvanced
  module VmwareExtensions
    def parse_args(inp_args)
      args = super(inp_args)

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
