module Guard
  class Gospel
    module Options
      DEFAULTS = {
        cmd: 'go',
        basename: 'go_spel',
        tempdir: '.tmp'
      }

      class << self
        def with_defaults(options = {})
          _deep_merge(DEFAULTS, options)
        end

        def _deep_merge(hash1, hash2)
          hash1.merge(hash2) do |key, oldval, newval|
            if oldval.instance_of?(Hash) && newval.instance_of?(Hash)
              _deep_merge(oldval, newval)
            else
              newval
            end
          end
        end
      end
    end
  end
end
