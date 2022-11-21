# frozen_string_literal: true

module ForemanVmwareAdvanced
  class Engine < ::Rails::Engine
    engine_name 'foreman_vmware_advanced'

    initializer 'foreman_vmware_advanced.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_vmware_advanced do
        requires_foreman '>= 1.14'
      end
    end

    config.to_prepare do
      ::Foreman::Model::Vmware.prepend ForemanVmwareAdvanced::VmwareExtensions
    rescue StandardError => e
      Rails.logger.warn "ForemanVmwareAdvanced: skipping engine hook(#{e})"
    end
  end
end
