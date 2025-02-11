# Viewing Party API

## Project Summary

This project involves building an API that allows users to explore movies and create Viewing Party events.
The API integrates with an external movie API to gather relevant movie data and facilitates the creation of viewing parties, where users can be invited, and one user can act as the host.
The project handles basic authorization and ensures the proper tracking of participants and hosts.
This project is considered a brownfield project, meaning that it was partially developed by another developer, and my task was to continue from where they left off.
The project focuses on enhancing and building upon an existing codebase, rather than fixing legacy issues.
I implemented new features, ensuring the application’s functionality is expanded and maintained.

## Learning Goals

- API Consumption: Integrate with an external API that requires authentication.
- CRUD Functionality: Build out CRUD functionality for a many-to-many relationship.
- Testing API Consumption: Implement at least one mocking tool for testing external API calls.
- Legacy Codebase: Work with an existing codebase, maintaining and refactoring code as necessary.
- Maintainable Code: Organize and refactor new code to ensure maintainability and scalability.

## Key Features

- External API Integration: Connects to an external movie API for retrieving movie details and exploring movie data.
- Viewing Party Management: Allows users to create and manage Viewing Parties, invite others, and assign hosts.
- User Authorization: Manages basic user authentication and ensures proper roles and responsibilities for party hosts and invitees.
- Many-to-Many Relationships: Utilizes a many-to-many relationship between users and viewing parties to track who is invited and who the host is.

## Requirements

- Ruby: 3.2.2
- Rails: "~> 7.1.3", ">= 7.1.3.4"
- PostgreSQL: Required for the database
- Postman: For help with testing routes, request bodies, and response bodies

## Key Gems

Key gems included in the Gemfile for development, testing, and production:

- rails: Web framework for building the API
- pg: PostgreSQL database adapter for Active Record
- puma: Web server used to run the application
- bcrypt: For handling user authentication and password security
- faraday: HTTP client for making API requests
- jsonapi-serializer: For serializing data to comply with the JSON:API specification
- pry: For debugging in development
- rspec-rails: For testing Rails applications
- shoulda-matchers: Provides additional matchers for testing
- webmock: For stubbing HTTP requests in tests
- vcr: For recording and replaying HTTP interactions during tests
- simplecov: For test coverage analysis

To install all the gems listed in the Gemfile and ensure your environment is set up correctly, run this command in the terminal: *bundle install*

## Installation

1) To install this project to your personal device, you will need to naviate to the viewing-partyp-api repo on my GitHub linked here: [text](https://github.com/JonoSommers/viewing-party-api)
2) (Optional) If you are looking to add this project to your repo, there should be an option to fork the repo in the top right corner of the page.
3) Otherwise, you should see a green box that says '<> code' ... Click it and it should display a dropdown menu. Make sure SSH is selected, and copy SSH key that is listed.
4) From there, navigate to the directory you wish to clone down this repo, and in your terminal, input: *git clone paste SSH key here*. This should create a new viewing-party-api directory.
5) Navigate into the newly created directroy mentioned, and input *code .* into your terminal and the project should open.

## Usage in Postman

### Top Rated Movies

This endpoint will retreive the top 20 rated movies from The Movie DB API, and include the title and vote average of every movie.
Route: api/v1/movies#index
Example route: <http://localhost:3000/api/v1/movies>
Request body: empty
Example response body:

```{
  "data": [
    {
      "id": "278",
      "type": "movie",
      "attributes": {
        "title": "The Shawshank Redemption",
        "vote_average": 8.706
      }
    },
    {
      "id": "238",
      "type": "movie",
      "attributes": {
        "title": "The Godfather",
        "vote_average": 8.69
      }
    },
    {
      "id": "240",
      "type": "movie",
      "attributes": {
        "title": "The Godfather Part II",
        "vote_average": 8.574
      }
    },
    // ... a maximum of 20 results listed
  ]
}
```

### Movie Search

This endpoint will retrieve the top 20 rated movies from The Movie DB API based on a search query from the request, and include the title and vote average of every movie.
Route: Route: api/v1/movies#index
Example route: <http://localhost:3000/api/v1/movies?title=Lor>
Request body: empty
Example response body:

```{
  "data": [
    {
      "id": "120", // This ID is from the Movie DB API, not your local database
      "type": "movie",
      "attributes": {
        "title": "The Lord of the Rings: The Fellowship of the Ring",
        "vote_average": 8.413
      }
    },
    {
      "id": "122",
      "type": "movie",
      "attributes": {
        "title": "The Lord of the Rings: The Return of the King",
        "vote_average": 8.698
      }
    },
    {
      "id": "240",
      "type": "movie",
      "attributes": {
        "title": "The Lord of the Rings: The Two Towers",
        "vote_average": 8.397
      }
    },
    // ... maximum of 20 results
  ]
}
```

### Create a Viewing Party

This endpoint will create a Viewing Party record and create the neccesary joins records to invite all the indicated users.
Route: Route: /api/v1/users/:user_id/viewing_parties#create
Example route: <http://localhost:3000/api/v1/users/1/viewing_parties>
Example request body:

``` {
  "name": "Jono's Movie Mania!",
  "start_time": "2025-02-01 18:00:00",
  "end_time": "2025-02-01 22:30:00",
  "movie_id": 120,
  "movie_title": "The Lord of the Rings: The Fellowship of the Ring",
  "invitees": [2, 3] // must be valid user IDs in the system
}
```

Example response body:

```{
  "data": {
    "id": "1",
    "type": "viewing_party",
    "attributes": {
      "name": "Jono's Movie Mania!",
      "start_time": "2025-02-01 18:00:00",
      "end_time": "2025-02-01 22:30:00",
      "movie_id": 120,
      "movie_title": "The Lord of the Rings: The Fellowship of the Ring",
      "invitees": [
        {
          "id": 2,
          "name": "Tyler, The Creator",
          "username": "BigT"
        },
                {
          "id": 3,
          "name": "Mac Miller",
          "username": "MacAttack"
        }
      ]
    }
  }
}
```

Sad paths that were handled:

- Request sent with missing required attributes for a viewing party
- Request sent with party duration less than movie runtime
- Request sent with end time before start time
- Request sent with an invalid user ID as one of the invitees

### Add Another user to Existing Viewing Party

This endpoint will not make any updates to the viewing party resouce, but instead just add more users to the party.
Route: Route: /api/v1/users/:user_id/viewing_parties/:viewing_party_id/users_viewing_parties/:id#update
Example route: <http://localhost:3000/api/v1/users/1/viewing_parties/1/users_viewing_parties/1>
Example request body:

```{
  "invitee_id": 4
}
```

Example response body:

```{
  "data": {
    "id": "1",
    "type": "viewing_party",
    "attributes": {
      "name": "Jono's Movie Mania!",
      "start_time": "2025-02-01 18:00:00",
      "end_time": "2025-02-01 22:30:00",
      "movie_id": 120,
      "movie_title": "The Lord of the Rings: The Fellowship of the Ring",
      "invitees": [
        {
          "id": 2,
          "name": "Tyler, The Creator",
          "username": "FlowerBoy"
        },
                {
          "id": 3,
          "name": "Mac Miller",
          "username": "LarryFisherman"
        },
                {
          "id": 4,
          "name": "Frank Ocean",
          "username": "FrankyOceans"
        }
      ]
    }
  }
}
```

Sad paths that were handled:

- Invalid viewing party ID
- Invalid user ID

## My info

- GitHub: [text](https://github.com/JonoSommers)
- LinkedIn: [text](https://www.linkedin.com/in/jonosommers/)
- Slack: @Jono Sommers
