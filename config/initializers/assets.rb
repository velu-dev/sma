# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join("node_modules")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( animate.css bootstrap.min.css line-awesome.css line-awesome-font-awesome.min.css font-awesome.min.css jquery.mCustomScrollbar.min.css slick.css slick-theme.css style.css responsive.css jquery.min.js popper.js bootstrap.min.js jquery.mCustomScrollbar.js slick.min.js scrollbar.js script.js )
