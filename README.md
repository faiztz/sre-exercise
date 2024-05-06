
# App Overview

This application is a Node.js web server that displays messages fetched from a PostgreSQL database. It is containerized using Docker and orchestrated with Docker Compose. The application infrastructure, including the PostgreSQL instance and Docker repository, is managed using Terraform in Google Cloud Platform (GCP).

## Usage

- **Access the application:** Navigate to (https://alp-hello-world-app-qlm5r3w6gq-uc.a.run.app) in your web browser to view the message from the database `hello world`.
- **Health Check:** Access (https://alp-hello-world-app-qlm5r3w6gq-uc.a.run.app/health) to check the server health.

## Technology Stack

- **Node.js** - Server-side JavaScript runtime.
- **Express.js** - Web application framework for Node.js.
- **PostgreSQL** - Open source relational database.
- **Docker** - Containerization platform.
- **Docker Compose** - Tool for defining and running multi-container Docker applications.
- **Terraform** - Infrastructure as Code software tool.
- **Google Cloud Platform (GCP)** - Cloud service provider.
- App  is using **Google Cloud Run, Google Artifact Registry, Google Cloud SQl(Postgres)** services to run the app


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
   - Create folder `gcp` in the root Dir and save key file in gcp folder (required for Terraform)


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
   cd app
   npm install
   ```
4. **Start the Application:**
   ```bash
   npm start
   ```

5. **Start the Application using docker:**
   - Using Docker Compose:
     ```bash
     docker-compose up
     
     ```
6. **Steps to deploy docker image to Google Artifact Registry**
   - gcloud auth configure-docker us-central1-docker.pkg.dev

   - Go to `app` folder run below commands to generate docker and push to artifact registry

   - docker-compose up

   - docker tag web-app:latest us-central1-docker.pkg.dev/inbound-muse-421417/my-docker-repo/node-app:latest

   - docker push us-central1-docker.pkg.dev/inbound-muse-421417/my-docker-repo/node-app:latest
   

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

## Contributing

Contributions to this project are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
