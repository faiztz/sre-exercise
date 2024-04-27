
# App Overview

This application is a Node.js web server that displays messages fetched from a PostgreSQL database. It is containerized using Docker and orchestrated with Docker Compose. The application infrastructure, including the PostgreSQL instance and Docker repository, is managed using Terraform in Google Cloud Platform (GCP).

## Technology Stack

- **Node.js** - Server-side JavaScript runtime.
- **Express.js** - Web application framework for Node.js.
- **PostgreSQL** - Open source relational database.
- **Docker** - Containerization platform.
- **Docker Compose** - Tool for defining and running multi-container Docker applications.
- **Terraform** - Infrastructure as Code software tool.
- **Google Cloud Platform (GCP)** - Cloud service provider.

## Requirements

- Node.js (Latest stable version)
- Docker and Docker Compose
- Google Cloud SDK, configured with access to your GCP account
- Terraform CLI

## GCP Setup

1. **Create a GCP Project:**
   - Go to the [Google Cloud Console](https://console.cloud.google.com/).
   - Click on the project drop-down and then click "New Project".
   - Fill out the project details and create the project.

2. **Create and Download a Service Account Key:**
   - In the Cloud Console, go to the "IAM & Admin > Service Accounts" section.
   - Click "Create Service Account", enter a name, and click "Create".
   - Assign the appropriate roles Recommended OWNER Role (e.g., Project > Owner).
   - Click on "Create Key", select JSON, and click "Create" to download the key file.
   - Securely store the downloaded key file.
   - Create golder `gcp` in the root Dir and save key file in gcp folder (required for Terraform)


## Local Setup and Installation

1. **Clone the Repository:**
   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. **Environment Setup:**
   - Create a `.env` file in the root directory with the necessary environment variables:
     ```
     PGUSER=<your-db-user>
     PGHOST=<your-db-host>
     PGDATABASE=<your-db-name>
     PGPASSWORD=<your-db-password>
     PGPORT=<your-db-port>
     ```

3. **Install Dependencies:**
   ```bash
   npm install
   ```

4. **Start the Application:**
   - Using Docker Compose:
     ```bash
     docker-compose up --build
     ```

## Deployment with Terraform

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Plan Deployment:**
   ```bash
   terraform plan
   ```

3. **Apply Configuration:**
   ```bash
   terraform apply
   ```

## Usage

- **Access the application:** Navigate to `http://localhost:8080/` in your web browser to view the message from the database.
- **Health Check:** Access `http://localhost:8080/health` to check the server health.

## Contributing

Contributions to this project are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
