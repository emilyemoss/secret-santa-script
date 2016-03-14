# Secret Santa

Randomly assign Secret Santa giftee <--> gifters and notify the group members using Twilio SMS.

*Sending SMS using Twilio is not free and requires a Twilio account with an account balance.*

## How to Use

**1. Add your Twilio variables:**

```
account_sid = 'XXX' # replace with your Twilio AccountSID
auth_token = 'XXX' # replace with your Twilio AuthToken
twilio_number = '+15552225555' # replace with your Twilio phone number
```

**2. Define each of your group members in `person.rb` as follows:**

`FirstName LastName 15552225555`

**3. Customize your SMS message:**

```
# add your custom message here
message = "Hi #{person.santa.first}, it's Santa! You're in charge of gifting #{person.first} for the Moss Family Secret Santa. Max $20 - $20 buys a LOT of Lucky Charms. Happy gifting!"
```

**4. Create your constraints:**

Script is currently configured to avoid matching any members with the same last name.

**5. Run the script and notify the Santas:**

`ruby person.rb people.txt`


### Want to keep the matches secret? 

Comment out lines [57](https://github.com/emilyemoss/secret-santa-script/blob/master/person.rb#L57) and [60](https://github.com/emilyemoss/secret-santa-script/blob/master/person.rb#L60) to prevent printing matches to the screen.
