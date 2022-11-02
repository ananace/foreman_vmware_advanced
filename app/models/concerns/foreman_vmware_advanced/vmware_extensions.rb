# frozen_string_literal: true

module ForemanVmwareAdvanced
  module VmwareExtensions
    def parse_args(inp_args)
      args = super(inp_args)

      args[:extra_config] = (args[:extra_config] || {}).merge(
        'bios.bootOrder': 'ethernet0',
        'svga.autodetect': 'TRUE'
      )

      if SETTINGS[:vtpm_csr] && SETTINGS[:vtpm_crt]
        args[:extra_config][:'vtpm.present'] = 'TRUE'
        args[:extra_config][:'vtpm.ekCSR'] = SETTINGS[:vtpm_csr]
        args[:extra_config][:'vtpm.ekCRT'] = SETTINGS[:vtpm_crt]
      end

      args[:extra_config][:'disk.EnableUUID'] = 'TRUE' if args[:guest_id]&.start_with?('win')

      args
    end
  end
end
