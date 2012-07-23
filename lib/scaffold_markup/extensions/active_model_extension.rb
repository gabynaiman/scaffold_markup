class ActiveModel::Name
  def human_plural
    plural = human(:count => 2)
    human == plural ? human.pluralize : plural
  end
end