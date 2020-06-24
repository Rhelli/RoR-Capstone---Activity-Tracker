module GroupsHelper
  def user_badges_gen(user, group)
    ranked_activities = group.activities.limit(3).order(calories: :desc).compact
    creator = group.creator
    if ranked_activities.first.author == user
      'fas fa-trophy gold'
    elsif ranked_activities.second.author == user
      'fas fa-trophy silver'
    elsif ranked_activities.last.author == user
      'fas fa-trophy bronze'
    elsif creator == user
      'fas fa-id-badge'
    end
  end

  def badges_phrase_gen(user, group)
    ranked_activities = group.activities.limit(3).order(calories: :desc).compact
    creator = group.creator
    if ranked_activities.first.author == user
      'Most Cals Burned'
    elsif ranked_activities.second.author == user
      '2nd Most Cals Burned'
    elsif ranked_activities.last.author == user
      '3rd Most Cals Burned'
    elsif creator == user
      'Group Admin'
    end
  end
end
