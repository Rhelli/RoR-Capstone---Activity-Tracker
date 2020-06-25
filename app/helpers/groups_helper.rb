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
      'fas fa-id-badge creator'
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

  def is_member?(user, group)
    user_groups = user.groups.compact
    user_groups.include?(group)
  end

  def group_icon_gen(type)
    case type
      when 'Athletics'
        'fas fa-running'
      when 'American Football'
        'fas fa-football-ball'
      when 'Archery'
        'fas fa-bullseye'
      when 'Badminton'
        'fas fa-table-tennis'
      when 'Ballet'
        'fas fa-running'
      when 'Baseball'
        'fas fa-baseball-ball'
      when 'Basketball'
        'fas fa-basketball-ball'
      when 'BJJ'
        'fas fa-fire-alt'
      when 'Bodybuilding'
        'fas fa-dumbbell'
      when 'Boxing'
        'fas fa-fire-alt'
      when 'BMX'
        'fas fa-biking'
      when 'Calisthentics'
        'fas fa-burn'
      when 'Canoeing'
        'fas fa-anchor'
      when 'Cardio'
        'fas fa-burn'
      when 'Crossfit'
        'fas fa-burn'
      when 'Cycling'
        'fas fa-biking'
      when 'Diving'
        'fas fa-water'
      when 'Equestrian'
        'fas fa-horse'
      when 'Fencing'
        'fas fa-mask'
      when 'Fitness Class'
        'fas fa-users'
      when 'Football'
        'fas fa-futbol'
      when 'Golf'
        'fas fa-golf-ball'
      when 'Gymnastics'
        'fas fa-fire-alt'
      when 'Hockey'
        'fas fa-hockey-puck'
      when 'Karate'
        'fas fa-user-ninja'
      when 'Jogging'
        'fas fa-running'
      when 'Kayaking'
        'fas fa-anchor'
      when 'Kung-Fu'
        'fas fa-user-ninja'
      when 'MMA'
        'fas fa-user-ninja'
      when 'Pole Dancing'
        'fas fa-burn'
      when 'Powerlifting'
        'fas fa-dumbbell'
      when 'Pilates'
        'fas fa-spa'
      when 'Rock Climbing'
        'fas fa-hand-rock'
      when 'Rowing'
        'fas fa-anchor'
      when 'Rugby'
        'fas fa-football-ball'
      when 'Running'
        'fas fa-running'
      when 'Skateboarding'
        'fas fa-snowboarding'
      when 'Skating'
        'fas fa-skating'
      when 'Skiing'
        'fas fa-skiing'
      when 'Squash'
        'fas fa-baseball-ball'
      when 'Snowboarding'
        'fas fa-snowboarding'
      when 'Stretching'
        'fas fa-burn'
      when 'Sumo'
        'fas fa-universal-access'
      when 'Surfing'
        'fas fa-water'
      when 'Swimming'
        'fas fa-swimmer'
      when 'Tai Chi'
        'fas fa-user-ninja'
      when 'Tennis'
        'fas fa-baseball-ball'
      when 'Triathlon'
        'fas fa-running'
      when 'Volleyball'
        'fas fa-volleyball-ball'
      when 'Walking'
        'fas fa-walking'
      when 'Water Aerobics'
        'fas fa-water'
      when 'Water Sports'
        'fas fa-water'
      when 'Weightlifting'
        'fas fa-dumbbell'
      when 'Wrestling'
        'fas fa-fire-alt'
      when 'Yoga'
        'fas fa-spa'
      when 'Other'
        'fas fa-burn'
      end
    end
end
