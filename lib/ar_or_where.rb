module ArOrWhere
  module Relation

    # a bit hackish OR clause implementation - consider using SQUEEL instead
    def or(other_scope)
      unless other_scope.instance_of? ActiveRecord::Relation
        raise ArgumentError, "relation required, got #{other_scope.class}"
      end

      # corner case: one of the scopes has no 'where' clause at all
      return self if self.where_values.empty?
      return other_scope if other_scope.where_values.empty?

      # Conditions from scopes
      c1 = where_values_conjunction(self)
      c2 = where_values_conjunction(other_scope)

      # Note: all joins, orders etc will be inherited from the first scope
      new_scope = self.clone
      new_scope.where_values = [c1.clone.or(c2)]
      new_scope
    end

    protected

    def where_values_conjunction(the_scope)
      the_scope.where_values.inject { |a, b| a.and(b) }
    end
  end
end


require 'arel'
require 'active_record'
ActiveRecord::Relation.send(:include, ArOrWhere::Relation)

