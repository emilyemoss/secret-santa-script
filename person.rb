require 'rubygems'
require 'twilio-ruby'

account_sid = 'XXX' # replace with your Twilio AccountSID
auth_token = 'XXX' # replace with your Twilio AuthToken
twilio_number = '+15552225555' # replace with your Twilio phone number

@client = Twilio::REST::Client.new account_sid, auth_token

class Person
  attr_reader :first, :last, :phone
  attr_accessor :santa

  def initialize(line)
    m = /(\S+)\s+(\S+)\s+(\d{11})/.match(line)
    raise unless m
    @first = m[1].capitalize
    @last = m[2].capitalize
    @phone = "+" + m[3]
  end

  def can_be_santa_of?(other)
    # add your contraint logic here
    @last != other.last
  end
end

filename = ARGV.first

input = open(filename)

people = []
input.each_line do |line|
   line.strip!
   puts line
   people << Person.new(line) unless line.empty?
end

santas = people.dup
people.each do |person|
   person.santa = santas.delete_at(rand(santas.size))
end

people.each do |person|
  unless person.santa.can_be_santa_of? person
    candidates = people.select { |p| p.santa.can_be_santa_of?(person) && person.santa.can_be_santa_of?(p) }
    raise if candidates.empty?
    other = candidates[rand(candidates.size)]
    temp = person.santa
    person.santa = other.santa
    other.santa = temp
    finished = false
  end
end

people.each do |person|
  printf "%s -> %s \n", person.santa.first, person.first
  # add your custom message here
  message = "Hi #{person.santa.first}, it's Santa! You're in charge of gifting #{person.first} for the Moss Family Secret Santa. Max $20 - $20 buys a LOT of Lucky Charms. Happy gifting!"
  puts message
  sms = @client.account.messages.create(
    :body => message,
    :to => person.santa.phone,
    :from => twilio_number
  )
  puts sms.sid
end