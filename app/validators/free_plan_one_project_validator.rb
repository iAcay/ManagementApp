class FreePlanOneProjectValidator < ActiveModel::Validator
  def validate(project)
    if project.new_record? && (project.account.projects.count > 0) && (project.account.plan_free?)
      project.errors.add(:base, 'Free plans cannot have more than one project.')
    end
  end
end
