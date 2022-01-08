#!/usr/bin/ruby
require 'optparse'

module Constants
  ORGANISATION = 'ghcr.io'
  USER = 'aaqaishtyaq'
  REPOSITORY = "#{ORGANISATION}/#{USER}"
  LATEST = 'latest'
end

module Builder
  class Service
    include Constants

    def initialize(args)
      @args = args
      @name = "#{REPOSITORY}/#{@args[:image]}"
      @dir = "dockerfiles/#{@args[:image].split('-').join('/')}"
      @tag = @args[:tag]
      @image = "#{@name}:#{@tag}"
      @image_latest_tag = "#{@name}:#{LATEST}"
    end

    def can_push?
      @args[:push] ? true : false
    end

    def build_container_image
      build_command = [
        "docker",
        "build",
        "--rm",
        "--force-rm",
        "-t",
        "#{@image}",
        "#{@dir}"
      ].join(' ')

      puts "Building Image #{@name} in Directory: #{@dir}"
      system("#{build_command}")
    end

    def push_container_imager
      # Tag the image as latest and push
      [@image, @image_latest_tag].map do |image|
        push_command = [
          "docker",
          "push",
          "#{image}"
        ].join(' ')
        puts "Pushing Image #{image} to #{REPOSITORY}"
        system("#{push_command}")
      end
    end

    def tag_image_latest_tag
      tag_command = [
        "docker",
        "tag",
        "#{@image}",
        "#{@image_latest_tag}"
      ].join(' ')
      puts "Tagging image to latest"
      system("#{tag_command}")
    end
  end

  class Client
    def initialize
      args = {}
      OptionParser.new do |opts|
        opts.on("-i", "--image IMAGE", "Image name")
        opts.on("-t", "--tag TAG", "Tag of the image")
        opts.on("-p", "--push", "Push the image")

      end.parse!(into: args)

      args[:tag] ||= 'latest'

      unless args[:image] and args[:tag]
        raise StandardError.new "Oops! No Image or Tag Provided"
      end

      @service = Builder::Service.new(args)
    end

    def build
      @service.build_container_image &&
        @service.tag_image_latest_tag
    end

    def push
      @service.can_push? &&
        @service.push_container_imager
    end

    def build_and_push
      build && push
    end
  end
end

builder = Builder::Client.new
builder.build_and_push
