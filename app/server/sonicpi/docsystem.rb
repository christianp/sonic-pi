#--
# This file is part of Sonic Pi: http://sonic-pi.net
# Full project source: https://github.com/samaaron/sonic-pi
# License: https://github.com/samaaron/sonic-pi/blob/master/LICENSE.md
#
# Copyright 2013, 2014 by Sam Aaron (http://sam.aaron.name).
# All rights reserved.
#
# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as this
# notice is included.
#++

module SonicPi
  module DocSystem

    def self.included(base)

      class << base
        include SonicPi::Util

        @@docs ||= {}

        def docs
          @@docs
        end

        def docs_html_map
          res = {}
          @@docs.each do |k, v|
            unless(v[:hide])
              html = ""
              html << "<h2><pre>#{v[:name]}<pre></h2>"
              req_args = []
              v[:args].each do |arg|
                n, t = *arg
                req_args << "#{n} (#{t})"
              end
              html << "<h2><pre>[#{req_args.join(', ')}]</pre></h2>"
              html << "<h3>#{v[:doc]}</h3>"
              res[k.to_s] = html
            end
          end
          res
        end

        def doc(*info)
          args_h = resolve_synth_opts_hash_or_array(info)
          @@docs[args_h[:name]] = args_h
        end
      end
    end
  end
end