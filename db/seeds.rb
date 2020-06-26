time_of_day = [
  'Early Morning ',
  'Morning ',
  'Mid-Morning ',
  'Mid-Day ',
  'Early-Afternoon ',
  'Afternoon ',
  'Late Afternoon ',
  'Early Evening ',
  'Evening ',
  'Night-Time ',
  '',
  '',
  ''
]

def activity_name_gen(id)
  return 'Jog' if id == 3
  return 'Swim' if id == 4
  return 'Kayak' if id == 5
  return 'HIIT Session' if id == 6
  return 'Weightlifting Session' if id == 7
  return 'Yoga' if id == 9
  return 'Pilates' if id == 10
  return 'Core Workout' if id == 11
  return 'Calisthenics' if id == 12
  return 'Rowing Session' if id == 13
  return 'Golfing' if id == 14
  return 'Frisbee Session' if id == 15
  return 'WWE Wrestling Championship' if id == 16
  return 'Other' if id == 17
  if id == 1
    ['Run', 'Marathon'].sample
  elsif id == 2
    ['Walk', 'Power-Walk'].sample
  elsif id == 8
    ['Spin', 'Cycle'].sample
  end
end

adjective_gen = [
  'Easy ',
  'Hard ',
  'Sweaty ',
  'Freezing ',
  'Long ',
  'Quick ',
  'Short ',
  'Tiring ',
  'Exhausting ',
  'Fast & Furious ',
  'Daily ',
  'Solid ',
  'Brisk ',
  'Savage ',
  'Surprisingly difficult ',
  'Heavy ',
  'Laughably Easy ',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  ''
]

group_names = [
  'Running',
  'Walking',
  'Jogging',
  'Swimming',
  'Kayaking',
  'HIIT',
  'Weight Lifting',
  'Cycling',
  'Yoga',
  'Pilates',
  'Abdominal Workouts',
  'Calisthenics',
  'Rowing',
  'Golf',
  'Extreme Frisbee',
  'Wrestling',
  'Other'
]

def time_gen(string)
  if string.include?('Early Morning') || string.include?('Morning') || string.include?('Mid-Morning')
    return Faker::Time.between_dates(from: Date.today - 30, to: Date.today, period: :morning)
  elsif string.include?('Mid-Day') || string.include?('Early Afternoon') || string.include?('Afternoon')
    return Faker::Time.between_dates(from: Date.today - 30, to: Date.today, period: :afternoon)
  elsif string.include?('Late Afternoon') || string.include?('Early Evening') || string.include?('Evening') || string.include?('Night Time')
    return Faker::Time.between_dates(from: Date.today - 30, to: Date.today, period: :evening)
  else
    return Faker::Time.between_dates(from: Date.today - 30, to: Date.today, period: :day)
  end
end

def group_icon_match(group_names)
  return "fas fa-running" if group_names == 'Running' || group_names == 'Jogging'
  return "fas fa-walking" if group_names == 'Walking'
  return "fas fa-swimmer" if group_names == 'Swimming'
  return "fas fa-anchor" if group_names == 'Kayaking' || group_names == 'Rowing'
  return "fas fa-heartbeat" if group_names == 'HIIT' || group_names == 'Cardio' || group_names == 'Other'
  return "fas fa-dumbbell" if group_names == 'Weight Lifting'
  return "fas fa-biking" if group_names == 'Cycling'
  return "fas fa-spa" if group_names == 'Yoga' || group_names == 'Pilates'
  return "fas fa-burn" if group_names == 'Abdominal Workouts' || group_names == 'Calisthenics' || group_names == 'Extreme Frisbee' || group_names == 'Wrestling'
  return "fas fa-golf-ball" if group_names == 'Golf'
end

User.create!(
  first_name: 'Jimbo',
  last_name: 'Baggins',
  email: 'jimbo@email.com',
  password: 'password',
  password_confirmation: 'password'
)

30.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email_domain = Faker::Internet.domain_name
  email = "#{first_name.downcase}"+"#{last_name.downcase}"+"@"+"#{email_domain}"
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: 'password',
    password_confirmation: 'password'
  )
end

17.times do |i|
  name = group_names[i]
  created_at = Faker::Time.between_dates(from: Date.today - 200, to: Date.today - 150, period: :day)
  updated_at = created_at
  creator_id = rand(1..30)
  Group.create!(
    name: name,
    description: nil,
    created_at: created_at,
    updated_at: updated_at,
    creator_id: creator_id,
    icon: group_icon_match(name)
  )
  Membership.create!(
    group_id: i + 1,
    user_id: creator_id,
    created_at: created_at,
    updated_at: updated_at
  )
end

User.all.each do |u|
  group_id_array = (1..17).to_a
  4.times do
    sample = group_id_array.sample
    group_id = sample
    created_at = Faker::Time.between_dates(from: Date.today - 120, to: Date.today - 80, period: :all)
    Membership.create!(
      user_id: u.id,
      group_id: group_id,
      created_at: created_at,
      updated_at: created_at
    )
    group_id_array.delete(sample)
  end
end

User.all.each do |u|
  u.memberships.each do |i|
    4.times do
      name_gen = adjective_gen.sample + time_of_day.sample + activity_name_gen(i.group_id)
      name = name_gen.to_s
      amount = rand(10..260)
      calories = rand(10..1200)
      created_at = time_gen(name)
      updated_at = created_at
      author_id = u.id
      Activity.create!(
        name: name,
        amount: amount,
        calories: calories,
        created_at: created_at,
        updated_at: updated_at,
        author_id: author_id,
        group_id: i.group_id
      )
    end
  end
end

Activity.all.each do |a|
  activity_id = a.id
  group_id = a.group_id
  created_at = a.created_at
  updated_at = created_at
  ActivityEntry.create!(
    activity_id: activity_id,
    group_id: group_id,
    created_at: created_at,
    updated_at: updated_at
  )
end

