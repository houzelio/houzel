module Sequel
  module Plugins
    module DelaySetAssociation
      # Depend on the validate_associated plugin.
      def self.apply(model)
        model.plugin :validate_associated
      end

      module InstanceMethods
        private

        # Set the given object as the associated object for the given one_to_one association reflection
        def set_one_to_one_associated_object(opts, o)
          if opts.dataset_need_primary_key? && new?
            delay_validate_associated_object(opts, o)
            after_create_hook { super(opts, o) }
            o
          else
            super
          end
        end
      end
    end
  end
end
