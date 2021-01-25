# frozen-string-literal: true

module Sequel
  module Plugins
    module NestedAssociation

      def self.apply(model)
        model.plugin :validate_associated
        model.plugin :instance_hooks
      end

      module ClassMethods
        # Freeze associations updating when freezing model class
        def freeze
          @nested_association_module.freeze if @nested_association_module

          super
        end

        def nested_association(association)
          include(@nested_association_module ||= Module.new) unless @nested_association_module

          raise(Error, "Nonexistent association: #{association}") unless r = association_reflection(association)
          type = r[:type]
          #supporting only ":one_to_one" association for the time being
          raise(Error, "Invalid association type: association: #{association}, type: #{type}") unless type == :one_to_one
          define_set_fields_method(r)
        end

        def define_set_fields_method(reflection)
          @nested_association_module.class_eval do
            define_method("set_#{reflection[:name]}_fields") do |hash, fields, opts = OPTS|
              set_association_fields(reflection, hash, fields, opts)
            end
          end
        end
      end

      module InstanceMethods

        def set_association_fields(ref, hash, fields, opts)
          assoc = ref[:name]

          meta = Hash.new
          meta[:opts] = opts
          meta[:reflection] = ref

          assoc_o = public_send(assoc)
          if assoc_o.present?
            nested_association_update(meta, assoc_o, hash, fields)
          else
            nested_association_create(meta, hash, fields)
          end
        end

        def nested_association_update(meta, obj, hash, fields)
          obj.set_fields(hash, fields, meta[:opts])
          if obj.modified?            
            nested_association(meta[:reflection], obj)
          end

          obj
        end

        def nested_association_create(meta, hash, fields)
          reflection = meta[:reflection]
          obj = reflection.associated_class.new

          obj.set_fields(hash, fields, meta[:opts])
          nested_association(reflection, obj)
          obj
        end

        def nested_association(ref, obj)
          modified!
          delay_validate_associated_object(ref, obj)

          after_save_hook { obj.save_changes() }
          obj
        end

      end
    end
  end
end
