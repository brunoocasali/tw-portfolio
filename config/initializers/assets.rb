# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

# $assets = Dir[Rails.root.join('app/controllers/**/*_controller.rb')].map { |path| path.match(/(\w+)_controller.rb/); $1 }.compact
$assets = ['admin', 'clients', 'grayscale', 'devise',  'gallery']

$assets.freeze

$assets.flatten.each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end
Rails.application.config.assets.precompile += ['jquery.old.js', '*.woff', '*.woff2']
