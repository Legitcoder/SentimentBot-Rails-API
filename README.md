# Sentiment Bot Rails API

<http://sentimentbot-1.herokuapp.com/api>

Teams JSON to get an idea of the data structure:

<http://sentimentbot-1.herokuapp.com/api/teams>

#### Sign Up

```
POST api/users
```
Request Body:

```
{ firstName: String, lastName: String, email: String, password: String }
```

#### Log In

```
POST api/tokens
```
Request Body:

```
{ email: String, password: String }
```

## Every Endpoint Below Requires JWT token in Authorization Header


#### Get User

```
GET api/users/:id
```
Request Body:

```
{ id: Integer }
```

Note: This endpoint should be used after logging in and decoding the JWT
token in the front end to get the userId to retrieve all user attributes. 

### User Endpoints 

#### Join a Team

```
POST api/join
```
Request Body:

```
{ code: Integer }
``` 

#### Create a Response(Feelzy)

```
POST api/users/:userId/responses
```
Request Body:

```
{ mood: String, emoji: String }
```
 Optional :

```
{ imageUrl: String, surveyId: Integer, longitude: Float, latitude: Float }
```

Note: Team receives responses through users
which is why surveyId is optional.
Beyond MVP once a user can join multiple teams
this will not work and needs to fixed. Longitude and Latitude is only required for mobile.

### Manager Endpoints

#### Create a Team

```
POST api/users/:userId/teams
```
Request Body:

```
{ teamName: String }
```

#### Get Team's User Responses(Feelzys)

```
GET api/teams/:teamId/responses
```
Request Body:

```
N/A
```

#### Create a Team's Survey

```
POST api/teams/:teamId/surveys
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


#### Update Survey

```
PUT api/surveys/:id
```
Request Body:

```
{ schedule: string }
```

Note: This is what will trigger the change in notification 
whether that be daily,weekly, or monthly.

#### Get Team's Surveys

```
GET api/teams/:teamId/surveys
```
Request Body:

```
N/A
```

Note: Only use first survey object in team's surveys array. MVP will be static to one survey.


#### Get Feeling options of a Survey
   
```
GET api/surveys/:surveyId/feelings
```
Request Body:

```
N/A
```


#### Create a Feeling option of a Survey
   
```
POST api/surveys/:surveyId/feelings
```
Request Body:

```
{ mood: String, emoji: String }
```

#### Delete a Feeling option of a Survey
   
```
DELETE api/feelings/:id
```
Request Body:

```
N/A
```

### Manager and User Endpoints

#### Leave Team or Remove User from Team
```
DELETE api/:teamid/users/:id
```
Request Body:

```
N/A
```

#### Change Password
```
POST api/changePassword
```
Request Body:

```
{ password: String }
```