#
# Peruse - A utility to ingest base images for dockerfiles 'FROM' block at build time
# Copyright (C) 2021 Aaqa Ishtyaq <aaqaishtyaq@gmail.com>
#
#
# This file is part of Peruse.
#
# Peruse is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Peruse is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Peruse.  If not, see <http://www.gnu.org/licenses/>.
#
module Peruse
  module Parser
    def replace_macros(path)
      dockerfile = File.read(path)
      re = /.*\#{INCLUDE:(.*)}/
      match_data = re.match(dockerfile)
      include_macro, base_image = match_data.to_a
      # Get the image id for base image.

    end

    def fetch_base_image
      # Check if base image 
    end
  end
end