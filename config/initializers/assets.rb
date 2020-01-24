# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( links/main.css )
Rails.application.config.assets.precompile += %w( tailwind.css.erb )
Rails.application.config.assets.precompile += %w( rtl/rtlSupport.css )
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf )
# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('vendor/javascripts')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'images')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.root.join('vendor/stylesheets')
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
