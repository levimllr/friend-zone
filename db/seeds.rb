# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# FILLER MATERIAL

gift_1 = 'I expect an offering! What better way to show someone you value them 
    than with something of value?'
gift_2 = 'I really like it when someone brings me a meaningful gift.'
gift_3 = 'Gifts are nice.'
gift_4 = 'Gifts are okay, but almost too easy.'
gift_5 = 'When I receive a gift I wonder if someone is trying to bribe me.' 
gift_examples = [gift_1, gift_2, gift_3, gift_4, gift_5]

time_1 = 'Spending time with people you care about is what life\'s all about'
time_2 = 'I really like spending time with those close to me!'
time_3 = 'Just hanging out can be okay sometimes.'
time_4 = 'Being around friends is okay if there\'s something to do.'
time_5 = 'Spending a lot of time with someone barely indicates the quality 
    of the relationship.'
time_examples = [time_1, time_2, time_3, time_4, time_5]

aff_1 = 'When people notice and compliment things about me, I feel like I can 
    trust them and my place in the world.' 
aff_2 = 'It\'s so nice when people I value say nice things about it.'
aff_3 = 'I can get into a nice complement.'
aff_4 = 'Words are words... but I can\'t help feeling a little better 
    when they\'re nice.'
aff_5 = 'You better walk the walk if you\'re going to talk the talk.'
aff_examples = [aff_1, aff_2, aff_3, aff_4, aff_5]

serv_1 = 'There is no greater expression of affection than when someone 
    intentionally puts you before themselves.'
serv_2 = 'When someone does something for me, that\'s when I know they 
    really care.'
serv_3 = 'Being taken care of is nice.'
serv_4 = 'I like being taken care of, but then I feel like I owe something.'
serv_5 = 'The impulse to serve can be a psychological hangup and fallback.'
serv_examples = [serv_1, serv_2, serv_3, serv_4, serv_5]

touch_1 = 'The body knows what\'s good for it, and I know no better language 
    for love than a loving touch.'
touch_2 = 'A good squeeze gets me up off my knees.'
touch_3 = 'Being touched can be a pleasant surprise.'
touch_4 = 'I like being touched but often feel a little uncomfortable with it.'
touch_5 = 'Don\'t touch me.'
touch_examples = [touch_1, touch_2, touch_3, touch_4, touch_5]

reln_types = ['family', 'best friend', 'friend', 'acquaintance', 'professional',
     'intimate', 'mentor', 'neighbor', 'frenemy', 'enemy', 'friend-of-a-friend']
num_reln_types = reln_types.length
reln_qualities = ['A', 'B', 'C', 'D', 'F']
num_reln_qualities = reln_qualities.length

meeting_types = ['1:1 hangout', 'group get-together', 'event', 'voice call', 
    'video call', 'text chat', 'email', 'letter']
num_meet_types = meeting_types.length

# GENERATE PEOPLE WITH ACCOUNTS

Person.create(username: 'beerjeans', password: 'coolrunnings', 
    password_confirmation: 'coolrunnings', first_name: 'Levi', 
    last_name: 'Miller', birthday: Date.civil(1991, 9, 24), 
    email: 'paullevimiller@gmail.com', phone_number: 8054554980, 
    admin: true, activated: true, activated_at: Time.zone.now)

10.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    phonenumber = Faker::PhoneNumber.phone_number.scan(/\d/).join('').to_i
    birthday = rand(Date.civil(1920, 1, 1)..Date.civil(2001, 06, 22)).to_date
    password = Faker::Internet.password

    newperson = Person.create(
        username: Faker::Internet.username(specifier: firstname), 
        password: password, password_confirmation: password, 
        first_name: firstname, last_name: lastname, birthday: birthday, 
        email: Faker::Internet.safe_email(name: firstname), 
        phone_number: phonenumber, activated: true, activated_at: Time.zone.now)

    love_language_rank = [1, 2, 3, 4, 5].shuffle

    newperson.love_language = LoveLanguage.create(
        gifts_rank: love_language_rank[0], 
        gifts_example: gift_examples[love_language_rank[0] - 1], 
        time_rank: love_language_rank[1], 
        time_example: time_examples[love_language_rank[1] - 1], 
        affirmation_rank: love_language_rank[2], 
        affirmation_example: aff_examples[love_language_rank[2] - 1], 
        service_rank: love_language_rank[3], 
        service_example: serv_examples[love_language_rank[2] - 1], 
        touch_rank: love_language_rank[4], 
        touch_example: touch_examples[love_language_rank[4] - 1])
end

# GENERATE PEOPLE WITHOUT ACCOUNTS

40.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    phonenumber = Faker::PhoneNumber.phone_number.scan(/\d/).join('').to_i
    birthday = rand(Date.civil(1920, 1, 1)..Date.civil(2001, 06, 22)).to_date

    newperson = Person.create(username: "nu" + "firstname", 
        password: "lastname" + "nu", first_name: firstname, last_name: lastname,
        birthday: birthday, email: Faker::Internet.safe_email(name: firstname), 
        phone_number: phonenumber, activated: true, activated_at: Time.zone.now)

    love_language_rank = [1, 2, 3, 4, 5].shuffle

    newperson.love_language = LoveLanguage.create(
        gifts_rank: love_language_rank[0], 
        gifts_example: gift_examples[love_language_rank[0] - 1], 
        time_rank: love_language_rank[1], 
        time_example: time_examples[love_language_rank[1] - 1], 
        affirmation_rank: love_language_rank[2], 
        affirmation_example: aff_examples[love_language_rank[2] - 1], 
        service_rank: love_language_rank[3], 
        service_example: serv_examples[love_language_rank[2] - 1], 
        touch_rank: love_language_rank[4], 
        touch_example: touch_examples[love_language_rank[4] - 1])

    newperson.save
end

numpeople = Person.all.length

# GENERATE RELATIONSHIPS

rand(150..350).times do
    person = Person.all[rand(0...numpeople)]
    friend = Person.all[rand(0...numpeople)]

    start_date = rand(person.birthday..Date.today).to_date
    reln_type = reln_types[rand(0...num_reln_types)]
    reln_quality = reln_qualities[rand(0...num_reln_qualities)]
    
    if person == friend || person.befriending.include?(friend)
        friend = Person.all[rand(0...numpeople)]
    end
    if !person.befriending.include?(friend)
        person.befriend(friend)
        new_person_reln = Relationship.all.last.update(
            reln_type: reln_type,
            quality: reln_quality,
            start: start_date
        )
        if !friend.befriending.include?(person)
            friend.befriend(person)
            new_friend_reln = Relationship.all.last.update(
                reln_type: reln_type,
                quality: reln_quality,
                start: start_date
            )
        end
    end
end

# GENERATE MEETINGS

rand(150..350).times do
    person = Person.all[rand(0...numpeople)]

    new_meeting = Meeting.create(when: rand(Date.civil(2014, 1, 1)..Date.today), location: Faker::Address.community, meeting_type: meeting_types[rand(0...num_meet_types)])

    person.meetings << new_meeting
    person_new_people_meeting = PeopleMeeting.last
    person_new_people_meeting.feeling = Faker::Hipster.word
    person_new_people_meeting.description = Faker::Hipster.sentence
    person_new_people_meeting.save

    rand(1..5).times do
        friend = Person.all[rand(0...numpeople)]
        if friend == person
            friend = Person.all[rand(0...numpeople)]
        end
        friend.meetings << new_meeting
        friend_new_people_meeting = PeopleMeeting.last
        friend_new_people_meeting.feeling = Faker::Hipster.word
        friend_new_people_meeting.description = Faker::Hipster.sentence
        friend_new_people_meeting.save
    end
end

nummeeting = Meeting.all.length

# GENERATE NOTES

rand(150..350).times do
    person = Person.all[rand(0...numpeople)]

    note_or_meeting_selector = rand(1..2)
    if note_or_meeting_selector == 1
        friend = Person.all[rand(0...numpeople)]
        if friend == person
            friend = Person.all[rand(0...numpeople)]
        end
        friend_note_title = friend.first_name + Faker::Lorem.word
        person.notes << Note.create(
            friend_id: friend.id, 
            title: friend_note_title, 
            content: Faker::Lorem.sentence(word_count: rand(1..7)))
    elsif note_or_meeting_selector == 2
        people_meeting = PeopleMeeting.all[rand(0...nummeeting)]
        meeting_note_title = people_meeting.meeting.location + Faker::Lorem.word
        person.notes << Note.create(
            people_meeting_id: people_meeting.id, 
            title: meeting_note_title, 
            content: Faker::Lorem.sentence(word_count: rand(1..7)))
    end
end

# GENERATE MICROPOSTS

people = Person.order(:created_at).take(10)
50.times do
    content = Faker::Lorem.sentence(5)
    people.each { |person| person.microposts.create!(content: content) }
end
