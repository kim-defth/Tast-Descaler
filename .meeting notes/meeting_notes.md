# Meeting notes

---

## 27 March 2024

Present:

* Karthik
* Dillan
* Kim
* Saad
* Bret
* Richard
* Donald

---

Talked about progress so far. Team hasn't yet fully settled on it but the plan is to try to use Agile approach.

Haven't defined any particular roles as yet.

We talked about how the team has got on so far - a simple React app has been created and committed to the repo.

There is a separate NodeJS lambda based on an AWS template, using Node 16, which has been manually deployed to one of the team's personal AWS accounts as a stop gap while they were waiting to get set up with AWS credentials for MR sandbox accounts.

We talked the team through how Github Actions and pipelines work in broad terms. The team told us that one of their big knowledge gaps is AWS itself.

They have now been set up with sandbox credentials so the expectation is that they can now start getting to grips with some of the AWS ecosystem.

It  was explained to the team what the security implications are of having access to AWS accounts - particularly in terms of activity that might raise potential security alerts - basically, try to let us know in Slack if you're up to anything interesting, and definitely make sure you are contactable when you're doing it.

We have contact details and the team is aware that if anything suspicious happens, they will be contacted, middle of the night or not.

### Highlights / things of note:

* We emphasised the importance of *NEVER COMMITTING SECRETS TO THE REPO* - if in doubt, you must reach out.

* Recommend that the team look at the bullet point criteria on the Github project tickets and work out collectively what needs to be done, before breaking the work down and allocating parts of it to individual team members. Remember, you can create and assign tasks within the Kanban board.


## May 1

Present:

Andrew Tyler - organiser
Richard Bowden
karthik.karavatt@student.curtin.edu.au
quykim.dam@student.curtin.edu.au
Donald Wade
m.lakdawala1@student.curtin.edu.au
Thashin Naidoo
admin@dillanbailey.com
Hamish Tedeschi - optional

have a workflow that pings and sends notifications
build breaks but nobody knows?
build, pass, fail notifs from logs

aim is to ACTUALLY get meaninful info
look at it from a scientific pov
prioritise hypothesis confirmation from github action logs
basically, periodically poll the broke build and send notifications
could try detecting from terraform/aws as well
warnings need to be detected as well

main question: Can we and how do we extract logs from the pipeline?

send an ss of milestones and stuff

try and do stuff together

try presenting on the screen

decide who does meeting minutes
