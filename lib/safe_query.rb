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
      r = User.select(sel_column(:user, :id), sel_column(:profile], [:name]))
      r = r.association_join(person: :profile)
      r
    end
  end
end
