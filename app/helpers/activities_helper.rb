module ActivitiesHelper
  def calories_ranker_phrases(activity)
    ranked_activities = current_user.activities.all.order(calories: :desc).limit(3).compact
    if activity.calories > ranked_activities.first.calories
      'Most Calories Burned In One Session'
    elsif activity.calories > ranked_activities.second.calories
      '2nd Most Calories Burned In One Session'
    elsif activity.calories > ranked_activities.last.calories
      '3rd Most Calories Burned In One Session'
    else
      'Practice Makes Perfect! Keep It Up!'
    end
  end

  def calories_badges_gen(activity)
    ranked_activities = current_user.activities.all.order(calories: :desc).limit(3).compact
    if activity.calories > ranked_activities.first.calories
      'fas fa-trophy gold'
    elsif activity.calories > ranked_activities.second.calories
      'fas fa-trophy silver'
    elsif activity.calories > ranked_activities.last.calories
      'fas fa-trophy bronze'
    else
      'fas fa-award award'
    end
  end

  def time_ranker_phrases(activity)
    ranked_times = current_user.activities.all.order(amount: :desc).limit(3).compact
    if activity.amount > ranked_times.first.amount
      'Fastest Ever Time'
    elsif activity.amount > ranked_times.second.amount
      'Second Fastest Time! Keep It Up!'
    elsif activity.amount > ranked_times.last.amount
      'Third Fastest Time! Keep It Up!'
    end
  end

  def time_badges_gen(activity)
    ranked_times = current_user.activities.all.order(amount: :desc).limit(3).compact
    if activity.amount > ranked_times.first.amount
      'fas fa-trophy gold'
    elsif activity.amount > ranked_times.second.amount
      'fas fa-trophy silver'
    elsif activity.amount > ranked_times.last.amount
      'fas fa-trophy bronze'
    end
  end

  def calories_per_minute_calc(activity)
    activity.calories / activity.amount
  end

  def calories_per_hour_calc(activity)
    hourly = 60.00 / activity.amount
    ans = activity.calories * hourly
    ans.to_i
  end
end
