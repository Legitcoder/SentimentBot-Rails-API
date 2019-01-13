# Sentiment Bot Rails API

##Sign up

```
POST api/tokens
```
Request Body:

```
{ firstName: email: String, password: String }
```


##Log In

```
POST api/users
```
Request Body:

```
{ email: String, password: String }
```

##Join a Team

```
POST api/join
```
Request Body:

```
{ code: Integer }
```

##Create a Team

```
POST api/teams
```
Request Body:

```
{ team: Integer }
```
