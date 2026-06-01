### A separate branch is present for the migration of this application to vue.js.

# SDS Tracker

A Safety Data Sheet (SDS) management application for tracking chemical inventory and GHS hazard records.

<img src="https://cdn.allthepics.net/images/2026/05/28/Screenshot-2026-05-28-081918.png" width="100%">

<img src="https://cdn.allthepics.net/images/2026/05/28/Screenshot-2026-05-28-081828.png" width="100%">

---

## Tech Stack

- **CFML** on Lucee (Adobe CF compatible)
- **H2** embedded relational database
- **Hibernate ORM** (Lucee built-in) - `dbcreate: update`
- **Bootstrap 5.3** for styling
- **REST API** with Swagger/OpenAPI 3.0 documentation
- **Layered architecture** - API handler → Service → DAO → ORM Model

---

## Project Structure

```
/
├── Application.cfc             # App config, datasource, ORM, REST init, singletons
├── index.cfm                   # Dashboard - stat cards, recent records, header search
├── main.css                    # Global styles
├── server.json                 # CommandBox server config (Lucee, REST mappings)
├── dbsdstracker.mv.db          # H2 database file
│
├── api/
│   ├── Application.cfc         # REST sub-application config
│   ├── Chemicals.cfc           # REST handlers: /rest/api/chemicals/*
│   └── Hazards.cfc             # REST handlers: /rest/api/hazards/*
│
├── services/
│   ├── ChemicalService.cfc     # Business logic for chemicals (incl. CAS validation)
│   └── HazardService.cfc       # Business logic for hazards
│
├── dao/
│   ├── ChemicalDAO.cfc         # ORM CRUD for Chemical entity
│   └── HazardDAO.cfc           # ORM CRUD for Hazard entity
│
├── models/
│   ├── Chemical.cfc            # ORM entity - id, name, casNumber
│   ├── Hazard.cfc              # ORM entity - id, name, hazardClass, signalWord, hCodes, pCodes, pictogramUrl
│   ├── ChemicalHazard.cfc      # ORM join entity
│   └── StoredChemical.cfc      # ORM entity for inventory
│
├── utilities/
│   ├── CasNumberValidator.cfc  # CAS number checksum validation
│   └── FormDataHandler.cfc     # Converts URL-encoded form POST body to JSON
│
├── ui/
│   ├── shared/
│   │   ├── head.cfm            # <head> - Bootstrap CSS, main.css, page title
│   │   ├── header.cfm          # Navbar - nav links, sitewide search form
│   │   └── footer.cfm          # Bootstrap JS bundle
│   ├── Inventory/
│   │   └── inventory.cfm
│   ├── manageRecords/
│   │   ├── chemicals.cfm       # List + delete chemicals
│   │   ├── createChemical.cfm  # Create chemical form (with CAS validation)
│   │   ├── hazards.cfm         # List + delete hazards
│   │   └── createHazard.cfm    # Create hazard form
│   ├── about/
│   │   └── about.cfm
│   └── swagger.cfm             # Swagger UI
│
└── public/
    └── api.yaml                # OpenAPI 3.0 spec
```

---

## REST API

Base URL: `http://127.0.0.1:4929`  
Full spec: `public/api.yaml` - viewable via `/ui/swagger.cfm`

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/rest/api/chemicals/getall` | List all chemicals |
| POST | `/rest/api/chemicals/create` | Create a chemical |
| DELETE | `/rest/api/chemicals/delete` | Delete a chemical by ID |
| GET | `/rest/api/hazards/getall` | List all hazards |
| POST | `/rest/api/hazards/create` | Create a hazard |
| DELETE | `/rest/api/hazards/delete` | Delete a hazard by ID |

POST bodies are `application/x-www-form-urlencoded`. DELETE bodies send the numeric ID as plain text.

---

## Getting Started

Requires [CommandBox](https://www.ortussolutions.com/products/commandbox).

```bash
box start
```

Server config is in `server.json`. The H2 database file is created automatically on first run via `dbcreate: update`.

The datasource `sdstracker` must be configured in Lucee admin or auto-provisioned by CommandBox before the application starts.

---

## Architecture Notes

**Singleton pattern** - services, DAOs, and utilities are instantiated once in `onApplicationStart()` and stored on the `application` scope.

**Form handling** - POST requests from HTML forms arrive as URL-encoded strings. `FormDataHandler.cfc` converts them to JSON before the service layer deserializes them.

**CAS validation** - `CasNumberValidator.cfc` implements the CAS checksum algorithm. The same logic is duplicated client-side in `createChemical.cfm` for immediate user feedback.

**Header search** - the sitewide search form in `header.cfm` is wired to dashboard search on `index.cfm` via `initHeaderSearch()`. It filters the in-memory data cache loaded by `loadDashboard()` - no additional API calls.
