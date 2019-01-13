# Sentiment Bot Rails API



### Sign Up

```
POST api/users
```
Request Body:

```
{ firstName: String, lastName: String, email: String, password: String }
```

### Log In

```
POST api/tokens
```
Request Body:

```
{ firstName: email: String, password: String }
```

## Every Endpoint Below Requires JWT token in Authorization Header 

### Join a Team

```
POST api/join
```
Request Body:

```
{ code: Integer }
```

### Create a Team

```
POST api/teams
```
Request Body:

```
{ teamName: String }
```

### Create a Survey

```
POST api/users/:userId/surveys
```
Request Body:

```
{ schedule: String }
```

 Optional :

```
{ question: String }
```

Note: Question is optional for now because MVP will 
simple ask "How do you feel?", however the field is
present for future feature expansion


### Delete a Feeling option of a Survey
   
```
DELETE api/surveys/:surveyId/feelings
```
Request Body:

```
N/A
```

### Leave Team or Remove User from Team
```
DELETE api/:teamid/users/:id
```
Request Body:

```
N/A
```

### Create a Response(Feelzy)

```
POST api/users/:userId/responses
```
Request Body:

```
{ mood: String, emoji: String, userId: Integer}
```
 Optional :

```
{ imageUrl: String, surveyId: Integer, longitude: Float, latitude: Float }
```

Note: Team receives responses through users
which is why surveyId is optional.
Beyond MVP once a user can join multiple teams
this will not work and needs to fixed.