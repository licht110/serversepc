require 'specinfra/properties'

module Specinfra
  module Helper
    module ExtraProperties
      def property
        Specinfra::ExtraProperties.instance.properties
      end
      def group_property
        Specinfra::ExtraProperties.instance.group_properties
      end
      def global_property
        Specinfra::ExtraProperties.instance.global_properties
      end
      def set_property(prop)
        Specinfra::ExtraProperties.instance.properties(prop)
      end
      def set_group_property(prop)
        Specinfra::ExtraProperties.instance.group_properties(prop)
      end
      def set_global_property(prop)
        Specinfra::ExtraProperties.instance.global_properties(prop)
      end
    end
  end
end
