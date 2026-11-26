[Svenska](README_sv.md)

# EventFlow

**Created:** `📆 2026-10-05`\
**Ending date:** `📆 2026-12-01`\
**Developed by:**
[`Emmased`](https://github.com/Emmased)
[`etc-ludwig`](https://github.com/etc-ludwig)
[`Jaktlund96`](https://github.com/Jaktlund96)
[`karja1337`](https://github.com/karja1337)
[`oliboh`](https://github.com/oliboh)

## Table of contents
- [Project purpose and target audience](README.md#project-purpose-and-target-audience)
- [Project dependencies](README.md#project-dependencies)
- [Set up and run the project](README.md#set-up-and-run-the-project)
- [Database setup](README.md#database-setup)
- [API](README.md#api)
- [Test instructions](README.md#test-instructions)
- [Security and privacy decisions](README.md#security-and-privacy-decisions)
- [Customer value](README.md#customer-value)
- [Central user experience](README.md#central-user-experience)
- [Technologies](README.md#technologies)
- [Git workflow](README.md#git-workflow)
- [Kanban board](README.md#kanban-board)
- [Folder structure](README.md#folder-structure)



## Project purpose and target audience
A web application for the Älvsbyn municipality that allows residents to find, search for, and register for local events.

Visitors can view upcoming events—complete with essential details such as date, start time, and location—and use a simple, secure method to register themselves or their group for an event.

To help visitors find events that match their interests, the application includes a search function, and events can also be filtered by category.

> [!IMPORTANT]
> No bookings are saved, and all events retrieved from the external API are **fictitious.**
>
> The project uses "Älvsbyn municipality" as a **fictitious client**. It is for demonstration purposes only and has no connection to any real municipality.


## Project dependencies
### Framework
- .NET 10.0 SDK (or newer)


## Set up and run the project
### 1. Copy the URL
Click `<>Code` and copy the HTTPS link, or copy it from below:
```
https://github.com/karja1337/K2-Projektinlamning.git
```
### 2. Clone the repository
Open the terminal, navigate to the folder where you want to clone the repo, and run:

```
git clone https://github.com/karja1337/K2-Projektinlamning.git
```

### 3. Clone and run the API

> [!IMPORTANT] 
> For the website to display data from the API, it must be run in a terminal in the background.

Fictional events are fetched from an external API: https://github.com/m-lindberg/eventflow-api \
See the project's API documentation: [API documentation](docs/api.md)

1. Clone the repository of the external API:
```
git clone https://github.com/m-lindberg/eventflow-api.git
```
2. In the terminal, navigate to the project folder.

```
cd eventflow-api
```
3. Run API:
```
dotnet run --urls http://localhost:5043/
```

### 4. Open EventFlow
Open `frontend\index.html` in your browser. Done!


> For more information: [GitHub Docs: Cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)




## Database setup
The project includes a fully functional database, though it is not connected to the project's frontend. To set up the database and view selected tables, the SQL files in the `database` folder can be run:

### Run SQL queries 
1. Ensure that SSMS is downloaded and has a local connection.
2. To set up the database and insert tables run the following file: 
```
database\01-schemaV2.sql
```
3. To add fictitious events to the tables, run the following file:
```
database\02-datav2.sql
```
4. To view the test data and tables, run the following file:
```
database\03-queries.sql
```
5. Create Views, Procedures, and Triggers, including tests by running their respective files:
```
04-views.sql
05-procedures.sql
06-trigger.sql
07-trigger-tests.sql
```



## API
We use an external API that contains fictitious data in JSON format.

### Known limitations with external API
- The external API contains only sample data, no real events.
- No bookings are saved.
- The external service may be unavailable.
- The contents of the JSON array may change, in which case new events will not have any images, as the images are hardcoded.



## Test instructions
### Simulate API errors
To simulate errors with the API, the following addresses can be used:
```
http://localhost:5043/api/events
http://localhost:5043/api/events/1
http://localhost:5043/api/events/9999
http://localhost:5043/api/test/empty
http://localhost:5043/api/test/error
```

### Expected results
`/api/events` – 200 OK and a list of events.\
`/api/events/1` – 200 OK and one event.\
`/api/events/9999` – for 404 Not Found.\
`/api/test/empty` – 200 OK and an empty list (`[]`).\
`/api/test/error` – 500 and a simulated error.

To view HTTP status codes, see **DevTools > Network > Headers**



## Security and privacy decisions
### Frontend security
- Output and input are handled securely using `textContent`.
- Error handling: In the event of an HTTP error, the website displays a clear error message containing next steps, without revealing technical information.

### Database Integrity Rules
- The database complies with the third normal form (3NF) and contains no transitive dependencies.
- The database model has been reviewed for insertion, update, and deletion anomalies.
- Each row in a table is identifiable by a unique primary key, which cannot be NULL.
- Relationships between tables are established using foreign keys, and all dependencies have been reviewed.



## Customer value
With EventFlow, residents of Älvsbyn municipality can view local events on a user-friendly and stylish website. The site is responsive—designed primarily for mobile screens, yet it scales seamlessly to larger displays. No features or information become inaccessible, regardless of screen size. All links and menus can be focused on and selected using the Tab key, ensuring the website is fully navigable via keyboard alone.

All events can be searched for using the website’s search function, or filtered by category via a simple drop-down menu.

Bookings are made using the form provided for a specific event. Both the booking and the event view can be cancelled at any time by selecting "Cancel booking" or by clicking the "X" button in the corner of the event card. When making a booking, visitors can specify the size of their party, allowing the organizer to keep track of the expected number of attendees. Visitors may book one or more events and will receive an on-screen confirmation once their booking is complete.



## Central user experience
- Find an event that interests you. You can search for events or filter by category.
- Click on your chosen event.
- Click the booking button to display the booking form.
- Enter your name, email, phone number, and the group size in the booking form.
- Click "Send booking".
- A confirmation of your booking will appear, containing the relevant information.

> [!WARNING]
> No bookings are saved. The website is not connected to the database.



## Technologies
The following languages and technologies have been used throughout the project.
- **HTML** - Structure and semantic elements.
- **CSS** - Layout and styling. Responsive design.
- **JavaScript** - Interaction, DOM manipulation, and event handling.
- **Fetch API** - Retrieves data asynchronously from external API with `async`/`await`.
- **JSON** - Data format for the responses from the API.
- **Git & Github** - Version control.



## Git workflow
The team has followed the GitHub Flow process:

- Create a new branch from `main`.
- Make small, clear commits on the new branch.
- Open a pull request.
- Complete at least one code review by another team member.
- Approve and merge into `main`.



## [Kanban board](https://github.com/users/karja1337/projects/2)
Click the heading above to view the team's Kanban board.



## Folder structure
```
K2-Projektinlamning
├── .vs
├── database
├── docs
│    ├── database-models
│    ├── Matrices
│    └── Presentation-Backup
└── frontend
     └── images
```

---
### [&#8593; Back to top &#8593;](README.md#eventflow)