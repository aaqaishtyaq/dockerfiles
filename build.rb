#/usr/bin/ruby

module Constants
  ORGANISATION = 'ghcr.io'
  USER = 'aaqaishtyaq'
  REPOSITORY = "#{ORGANISATION}/#{USER}"
end

module Builder
  module Build
    class << self
      include Constants

      def input
        puts "Which image to build: "
        input = gets.strip
        docker_build(input)
      end

      private

      def docker_build suite
        image_name = "#{REPOSITORY}/#{suite}"
        dir = suite.split('-').join('/')
        build_command = [
          "docker",
          "build",
          "--rm",
          "--force-rm",
          "-t",
          "#{image_name}",
          "#{dir}"
        ].join(' ')

        puts "Building Image #{image_name} in Directory: #{dir}"
        exec("#{build_command}")
      end
    end
  end
end

Builder::Build.input
