source 'https://rubygems.org' do

	gem 'bundler', '>= 1.8.4' 

	# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
	gem 'rails', '4.1.8'

	gem 'rake'

	gem 'sprockets-rails', '2.2.4'

	# define database type to use for Active Record
	gem 'sqlite3', group: [:development, :test]

	# Use SCSS for stylesheets
	gem 'sass-rails', '~> 4.0.3'
	# Use Uglifier as compressor for JavaScript assets
	gem 'uglifier', '>= 1.3.0'
	# Use CoffeeScript for .js.coffee assets and views
	gem 'coffee-rails', '~> 4.0.0'

	# use Font Awesame as font and css toolkit
	gem 'font-awesome-rails'
	#gem 'font-awesome-sass'

	# Use jquery as the JavaScript library
	gem 'jquery-rails'
	# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
	gem 'turbolinks'
	# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
	gem 'jbuilder', '~> 2.0'
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', '~> 0.4.0', group: :doc

	# Use ActiveModel has_secure_password
	gem 'bcrypt', '~> 3.1.7'

	# Use unicorn as the app server
	# gem 'unicorn'

	# Use Capistrano for deployment
	# gem 'capistrano-rails', group: :development

	# Use debugger
	# gem 'debugger', group: [:development, :test]

	# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
	gem 'tzinfo-data', platforms: [:mingw, :mswin]

	# add support for interactive file uploads with image resizing for thumbnails
	gem 'rmagick', '2.14.0'
	gem 'carrierwave'

	# allow to rename to complete rails
	gem 'rename', group: :development

	# see https://github.com/woahdae/active_record_or
	#gem' active_record_or'

	# see https://github.com/rails/arel
	gem 'arel'

	# define dependencies for the production environment on railshoster.com
	group :production do 
	  gem 'dotenv-rails'
	  #gem 'libv8', '~> 3.11.8.17'
	  gem 'therubyracer', :platform => :ruby
	  gem 'mysql2'
	end

end

source 'https://rails-assets.org' do
	#gem 'rails-assets-bootstrap'
  	#gem 'rails-assets-angular'
  	#gem 'rails-assets-leaflet'
end