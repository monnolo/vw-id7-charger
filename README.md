VW ID.7 Tourer Pro Charging Calculator

A self-hosted PWA (Progressive Web App) to calculate charging times for the VW ID.7 Tourer Pro (77 kWh).

Features

Material Design 3 UI: Optimized for mobile and touch.

Smart Calculation: Uses the specific charging curve of the ID.7 (AC vs DC logic).

Visual Feedback: Real-time battery visualization.

PWA Support: Can be installed on Android home screens.

Installation

Prerequisites

Docker & Docker Compose

A folder to host the assets

Quick Start

Run the setup script to download assets and generate the app:

bash setup.sh


Start the container:

docker compose up -d


Access at http://your-server-ip:8555

Files

setup.sh: The master script. Downloads images (Car, Logo) and generates the index.html.

docker-compose.yml: The Nginx server configuration.

index.html: The generated web application.
