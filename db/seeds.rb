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

activity_name_gen = [
  'Run',
  'Walk',
  'Jog',
  'Swim',
  'Power-walk',
  'Kayak',
  'HIIT Session',
  'Weightlifting Session',
  'Cycle',
  'Spin',
  'Yoga',
  'Pilates',
  'Core Workout',
  'Calisthenics',
  'Rowing Session',
  'Golfing',
  'Frisbee Session',
  'WWE Wrestling Championship',
  'Marathon'
]

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
  'Cardio',
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

User.create!(first_name: 'Jimbo', last_name: 'Baggins', email: 'jimbo@email.com', password: 'password', password_confirmation: 'password')

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

User.all.each do |u|
  2.times do
    name_gen = adjective_gen.sample + time_of_day.sample + activity_name_gen.sample
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
      author_id: author_id
    )
  end
end

18.times do |i|
  name = activity_name_gen[i]
  created_at = Faker::Time.between_dates(from: Date.today - 200, to: Date.today - 150, period: :day)
  updated_at = created_at
  creator_id = rand(1..30)
  Group.create!(
    name: name,
    description: nil,
    created_at: created_at,
    updated_at: updated_at,
    creator_id: creator_id
  )
end

User.all.each do |u|
  group_id_array = (1..18).to_a
  3.times do
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

def group_match(object)
  return 1 if object.name.include?('Run') || object.name.include?('Marathon')
  return 2 if object.name.include?('Walk') || object.name.include?('Power-walk')
  return 3 if object.name.include?('Jog')
  return 4 if object.name.include?('Swim')
  return 5 if object.name.include?('Kayak')
  return 6 if object.name.include?('HIIT Session')
  return 7 if object.name.include?('Weightlifting Session')
  return 8 if object.name.include?('Cycle')
  return 9 if object.name.include?('Spin')
  return 10 if object.name.include?('Yoga')
  return 11 if object.name.include?('Pilates')
  return 12 if object.name.include?('Core Workout')
  return 13 if object.name.include?('Calisthenics')
  return 14 if object.name.include?('Rowing Session')
  return 15 if object.name.include?('Golfing')
  return 16 if object.name.include?('Frisbee Session')
  return 17 if object.name.include?('WWE Wresting Championship')
  return 18
end

Activity.all.each do |a|
  activity_id = a.id
  group_id = group_match(a)
  created_at = a.created_at
  updated_at = created_at
  ActivityEntry.create!(
    activity_id: activity_id,
    group_id: group_id,
    created_at: created_at,
    updated_at: updated_at
  )
end

