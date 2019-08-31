# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

gift_1 = 'I expect an offering! What better way to show someone you value them than with something of value?'
gift_2 = 'I really like it when someone brings me a meaningful gift.'
gift_3 = 'Gifts are nice.'
gift_4 = 'Gifts are okay, but almost too easy.'
gift_5 = 'When I receive a gift I wonder if someone is trying to bribe me.' 
gift_examples = [gift_1, gift_2, gift_3, gift_4, gift_5]

time_1 = 'Spending time with people you care about is what life\'s all about'
time_2 = 'I really like spending time with those close to me!'
time_3 = 'Just hanging out can be okay sometimes.'
time_4 = 'Being around friends is okay if there\'s something to do.'
time_5 = 'Spending a lot of time with someone barely indicates the quality of the relationship.'
time_examples = [time_1, time_2, time_3, time_4, time_5]

aff_1 = 'When people notice and compliment things about me, I feel like I can trust them and my place in the world.' 
aff_2 = 'It\'s so nice when people I value say nice things about it.'
aff_3 = 'I can get into a nice complement.'
aff_4 = 'Words are words... but I can\'t help feeling a little better when they\'re nice.'
aff_5 = 'You better walk the walk if you\'re going to talk the talk.'
aff_examples = [aff_1, aff_2, aff_3, aff_4, aff_5]

serv_1 = 'There is no greater expression of affection than when someone intentionally puts you before themselves.'
serv_2 = 'When someone does something for me, that\'s when I know they really care.'
serv_3 = 'Being taken care of is nice.'
serv_4 = 'I like being taken care of, but then I feel like I owe something.'
serv_5 = 'The impulse to serve can be a psychological hangup and fallback.'
serv_examples = [serv_1, serv_2, serv_3, serv_4, serv_5]

touch_1 = 'The body knows what\'s good for it, and I know no better language for love than a loving touch.'
touch_2 = 'A good squeeze gets me up off my knees.'
touch_3 = 'Being touched can be a pleasant surprise.'
touch_4 = 'I like being touched but often feel a little uncomfortable with it.'
touch_5 = 'Don\'t touch me.'
touch_examples = [touch_1, touch_2, touch_3, touch_4, touch_5]

relationship_types = ['family', 'best friend', 'friend', 'acquaintance', 'professional', 'intimate', 'mentor', 'neighbor']
    num_types = relationship_types.length

meeting_types = ['1:1 hangout', 'group get-together', 'event', 'voice call', 'video call', 'text chat', 'email', 'letter']

10.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    phonenumber = Faker::PhoneNumber.phone_number.scan(/\d/).join('').to_i
    birthday = rand(Date.civil(1920, 1, 1)..Date.civil(2001, 06, 22)).to_date

    newperson = Person.create(username: Faker::Internet.username(specifier: firstname), password: Faker::Internet.password, first_name: firstname, last_name: lastname, birthday: birthday, email: Faker::Internet.safe_email(name: firstname), phone_number: phonenumber)

    love_language_rank = [1, 2, 3, 4, 5].shuffle

    newperson.love_language = LoveLanguage.create(gifts_rank: love_language_rank[0], gifts_example: gift_examples[love_language_rank[0] - 1], time_rank: love_language_rank[1], time_example: time_examples[love_language_rank[1] - 1], affirmation_rank: love_language_rank[2], affirmation_example: aff_examples[love_language_rank[2] - 1], service_rank: love_language_rank[3], service_example: serv_examples[love_language_rank[2] - 1], touch_rank: love_language_rank[4], touch_example: touch_examples[love_language_rank[4] - 1])
end

40.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    phonenumber = Faker::PhoneNumber.phone_number.scan(/\d/).join('').to_i
    birthday = rand(Date.civil(1920, 1, 1)..Date.civil(2001, 06, 22)).to_date

    newperson = Person.create(first_name: firstname, last_name: lastname, birthday: birthday, email: Faker::Internet.safe_email(name: firstname), phone_number: phonenumber)

    love_language_rank = [1, 2, 3, 4, 5].shuffle

    newperson.love_language = LoveLanguage.create(gifts_rank: love_language_rank[0], gifts_example: gift_examples[love_language_rank[0] - 1], time_rank: love_language_rank[1], time_example: time_examples[love_language_rank[1] - 1], affirmation_rank: love_language_rank[2], affirmation_example: aff_examples[love_language_rank[2] - 1], service_rank: love_language_rank[3], service_example: serv_examples[love_language_rank[2] - 1], touch_rank: love_language_rank[4], touch_example: touch_examples[love_language_rank[4] - 1])
end

numpeople = Person.all.length

250.times do
    befriender = Person.all[rand(0...numpeople)]
    befriendee = Person.all[rand(0...numpeople)]

    start_date = rand(befriender.birthday..Date.today).to_date
    
    if befriender == befriendee || befriender.befriendees.include?(befriendee)
        befriendee = Person.all[rand(0...numpeople)]
    end
    if !befriender.befriendees.include?(befriendee)
        Relationship.create(befriender_id: befriender.id, befriendee_id: befriendee.id, reln_type: relationship_types[rand(0...num_types)], start: start_date)
    end
end

250.times do
    person = Person.all[rand(0...numpeople)]
    friend = Person.all[rand(0...numpeople)]
    if friend == person
        friend = Person.all[rand(0...numpeople)]
    end

    person.meetings << Meeting.create(location:
end
