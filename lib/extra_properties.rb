require 'singleton'

module Specinfra
  class ExtraProperties < Specinfra::Properties
    def initialize
      @global_prop = {}
      @group_prop = {}
    end
    def global_properties(global_prop=nil)
      if ! global_prop.nil?
        @global_prop = global_prop
      end
      @global_prop
    end
    def group_properties(group_prop=nil)
      if ! group_prop.nil?
        @group_prop = group_prop
      end
      @group_prop
    end
  end
end
