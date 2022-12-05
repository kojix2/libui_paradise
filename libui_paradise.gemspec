# =========================================================================== #
# Gemspec for this project.
# =========================================================================== #
require 'libui_paradise/version/version.rb'
require 'roebe/toplevel_methods/misc.rb'

Gem::Specification.new { |s|

  s.name    = 'libui_paradise'
  s.version = LibuiParadise::VERSION
  s.date    = Time.now.strftime('%Y-%m-%d')
  
  DESCRIPTION = <<-EOF

This project bundles together some custom bindings and code to the
official (upstream) ruby-libui interface. ruby-libui, in turn,
makes available code written in the libui project. You can find
the libui project here: https://github.com/andlabs/libui and 
the ruby-libui bindings maintained by kojix2 here:

  https://rubygems.org/gems/libui

For more documentation about the libui_paradise gem, please have a look
at the official homepage of this gem at rubygems.org, at its
documentation/ link on the bottom right hand side (or just use
this link directly:
  https://www.rubydoc.info/gems/libui_paradise/
)

  EOF

  s.summary     = DESCRIPTION
  s.description = DESCRIPTION

  s.authors  = ['Robert A. Heiler']
  s.email    = Roebe.email?
  s.files    = Dir['**/*']
  s.license  = 'MIT'
  s.homepage = 'https://www.rubydoc.info/gems/libui_paradise/'

  s.required_ruby_version     = '>= '+Roebe.third_most_stable_version_of_ruby
  s.required_rubygems_version = '>= '+Gem::VERSION
  s.rubygems_version          = '>= '+Gem::VERSION

  # ========================================================================= #
  # Dependencies for the project:
  # ========================================================================= #
  s.add_dependency 'libui'

}