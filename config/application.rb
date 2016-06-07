require File.expand_path('../boot', __FILE__)

require 'rails'

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Portfolio
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller

    config.time_zone = 'Brasilia'
    config.active_job.queue_adapter = :delayed_job
    config.i18n.default_locale = :'pt-BR'

    Dir.glob(Rails.root.join('config/locales/**/*/')).each do |dir|
      paths['config/locales'] << dir
    end

    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.hidden_namespaces << :test_unit << :erb << :mongoid << :less << :sass << :scss << :js << :coffee << :active_record
      g.view_specs      false
      g.helper_specs    false
      g.assets          false
      g.helper          false
      g.template_engine :slim
    end
  end
end
