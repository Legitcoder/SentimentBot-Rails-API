# Sentiment Bot Rails API

## Sign up

```
POST api/tokens
```
Request Body:

```
{ firstName: email: String, password: String }
```


## Log In

```
POST api/users
```
Request Body:

```
{ email: String, password: String }
```

## Join a Team

```
POST api/join
```
Request Body:

```
{ code: Integer }
```

## Create a Team

```
POST api/teams
```
Request Body:

```
{ teamName: String }
```

## Create a Survey

```
POST api/users/:userId/surveys
```
Request Body:

```
{ mood: String, emoji: String, userId: Integer }
```

## Create a Response(Feelzy)

```
POST api/users/:userId/responses
```
Request Body:

```
{ mood: String, emoji: String, userId: Integer }
```
 Optional :

```
{ imageUrl: String, surveyId: Integer }
```

Note: Team receives responses through users
which is why surveyId is optional

