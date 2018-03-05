module ForemanVmwareAdvanced
  class Engine < ::Rails::Engine
    engine_name 'foreman_vmware_advanced'

    initializer 'foreman_vmware_advanced.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_vmware_advanced do
        requires_foreman '>= 1.14'
      end
    end

    config.to_prepare do
      begin
        ::Foreman::Model::Vmware.send :include, ForemanVmwareAdvanced::VmwareExtensions
      rescue => e
        Rails.logger.warn "ForemanVmwareAdvanced: skipping engine hook(#{e})"
      end
    end
  end
end
