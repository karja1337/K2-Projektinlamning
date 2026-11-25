[Svenska](README_sv.md)

# EventFlow

**Created:** `📆 2026-10-05`\
**Finished:** `📆 2026-12-01`\
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
- [Database](README.md#database)
- [API](README.md#api)
- [Security and privacy decisions](README.md#security-and-privacy-decisions)
- [Customer value](README.md#customer-value)
- [Central user experience](README.md#central-user-experience)
- [Methods](README.md#methods)
- [Git workflow](README.md#git-workflow)
- [Kanban board](README.md#kanban-board)
- [Folder structure](README.md#folder-structure)


## Project purpose and target audience
A web application for Älvsbyn municipality that allows residents to find, search for, and register for local events.

Visitors can view upcoming events—including essential details such as date, start time, and location—and use a simple, secure method to register themselves or a group for an event.

To help visitors find events that match their interests, the events can also be filtered by category. 

> [!IMPORTANT]
> No bookings are saved, and all events retrieved from the external API are **fictitious.**




## Project dependencies
### Framework
- .NET 10.0 SDK (or newer)

### Program
- SSMS or other programs that can run and view SQL-queries.


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
Fictional events are fetched from an external API: https://github.com/m-lindberg/eventflow-api

Clone the repository:
```
git clone https://github.com/m-lindberg/eventflow-api.git
```
In the terminal, navigate to the project folder `.\eventflow-api` and then run:

```
dotnet run --urls http://localhost:5043/
```
> [!IMPORTANT]
> Keep the terminal open to run the API in the background.

### 4. Open EventFlow
Open `frontend\index.html` in your browser to see EventFlow. Done!


> For more information: [GitHub Docs: Cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)




## Database
The project includes a fully functional database, though it is not connected to the project's frontend. To set up the database and view selected tables, the SQL files in the `database` folder can be run, in the order listed:

### Run SQL queries 
Ensure that SSMS is downloaded and has a local connection.\
In SSMS, run the following file to set up the database and to insert tables: 
```
database\01-schemaV2.sql
```
To add fictitious events to the tables, run the following file:
```
database\02-datav2.sql
```
To view the test data and tables, run the following file:
```
database\03-queries.sql
```
Create Views, Procedures, and Triggers, including tests by running the following files located in the `database` folder:
```
database
├─ 04-views.sql
├─ 05-procedures.sql
├─ 06-trigger.sql
└─ 07-trigger-tests.sql
```



## API
### Simulate API errors
To simulate errors with the API, the following addresses can be used:
```
http://localhost:5043/api/events
http://localhost:5043/api/events/1
http://localhost:5043/api/events/9999
http://localhost:5043/api/test/empty
http://localhost:5043/api/test/error
```

`/api/events` – 200 OK and a list of events.\
`/api/events/1` – 200 OK and one event.\
`/api/events/9999` – for 404 Not Found.\
`/api/test/empty` – 200 OK and an empty list (`[]`).\
`/api/test/error` – 500 and a simulated error.

To view HTTP status codes, see **DevTools > Network > Headers**

### Known limitations with external API
- The external API contains only sample data; no real events.
- No bookings are saved.
- The external service may be unavailable.




## Security and privacy decisions
N/A



## Customer value
N/A



## Central user experience
N/A



## Methods
N/A



## Git workflow
N/A



## [Kanban board](https://github.com/users/karja1337/projects/2)
N/A



## Folder structure
```
K2-Projektinlamning
├── .vs
├── database
├── docs
│    └── database-models
└── frontend
     └── images
```

---
### [&#8593; Back to top &#8593;](README.,md#eventflow)