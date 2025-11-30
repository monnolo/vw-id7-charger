cat << 'EOF' > README.md
# VW ID.7 Tourer Pro Charging Calculator

A self-hosted PWA (Progressive Web App) to calculate charging times for the VW ID.7 Tourer Pro (77 kWh).

## Features

* **Material Design 3 UI**: Optimized for mobile and touch.

* **Smart Calculation**: Uses the specific charging curve of the ID.7 (AC vs DC logic).

* **Visual Feedback**: Real-time battery visualization.

* **PWA Support**: Can be installed on Android home screens with a proper icon.

## Installation

### Prerequisites

* Docker & Docker Compose

* A folder to host the assets on your server

### Quick Start

1. **Download & Install**: Run the setup script to download assets (images/logos) and generate the app files:bash setup.sh

2. **Start the Container**:docker compose up -d
3. **Access the App**:
Open your browser and navigate to `http://your-server-ip:8555`.

## Project Structure

* `setup.sh`: The installer script. Downloads assets and generates the HTML.

* `docker-compose.yml`: Configuration for the Nginx web server container.

* `index.html`: The main web application code.

* `manifest.json`: Configuration for Android PWA installation.

* `car.webp` & `icon.png`: Local assets served by the app.

## Updates

To update the app code, simply edit `index.html` or `setup.sh` and then run:git add . git commit -m "Update description" git push
EOF

