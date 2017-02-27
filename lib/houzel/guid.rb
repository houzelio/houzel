module Houzel::Guid

  def self.included(model)
    model.class_eval do
      def before_create 
        set_guid
        super
      end
    end
  end

  def set_guid
    self.guid = UUID.generate :compact if self.guid.blank?
  end
end
