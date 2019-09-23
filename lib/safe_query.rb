module SafeQuery
  class Base
    def sel_column(relation, column, as = nil)
      expr = Sequel[relation][column]
      expr = expr.as(as) unless as.nil?
      expr
    end
  end

  class MedProfessionals < Base
    def examiners
      r = Person.select(sel_column(:person, :id), sel_column(:profile, :name))
      r = r.association_join(:profile)
      r
    end
  end
end
