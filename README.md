# payments-data-platform

Data platform for a payments company. It moves transaction data from the application database into clean, tested tables that analysts and reports can trust.

## Stack

- PostgreSQL 18
- Python 3.11 (psycopg, pandas)
- Planned: dbt for transformations, Airflow for scheduling

## Repository layout

| Folder   | Contents                                        |
|----------|-------------------------------------------------|
| `sql/`   | Table definitions and transformation queries    |
| `src/`   | Python code for loading and checking data       |
| `tests/` | Automated tests                                 |
| `docs/`  | Design notes and data model                     |

## Database layers

Data moves through these schemas in order:

| Schema         | Purpose                                              |
|----------------|------------------------------------------------------|
| `app`          | Source system tables, as the application writes them |
| `raw`          | Copies of source data, unchanged                     |
| `staging`      | Cleaned, typed and deduplicated                      |
| `intermediate` | Shared joins and business logic                      |
| `marts`        | Facts and dimensions for reporting                   |

## Local setup

1. Clone the repository.
2. Create a virtual environment: `python3 -m venv .venv`
3. Activate it: `source .venv/bin/activate`
4. Install the libraries: `pip install -r requirements.txt`
5. Copy `.env.example` to `.env` and fill in your database settings.
