# Priyank Vaidya
# Version 1.0
# 
# Containerisation of backend application


FROM node:18.16.0
FROM python:3.8-slim

# Running firstly the backend Application
WORKDIR /backend

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm                       

COPY package*.json ./
RUN npm install 

COPY . .

# Requirement for configuring the Postgres Password in the VM
# ----------------------------------------------------------------------------------------
#Copying the Bash Script for configuring the Postgres Image Application

WORKDIR ./backend/scripts
COPY ./configure-postgres-password.sh ./

# Set the script as executable
RUN chmod +x ./configure-postgres-password.sh
# ----------------------------------------------------------------------------------------

#Build the application
# RUN npm build

WORKDIR /backend/ml_model

COPY ./ml_model/requirements.txt .

RUN pip install -r requirements.txt 

#Copy the Entire Application
COPY ./ml_model ./backend/ml_model

# -----------------------------------------------------------------------
# Used to configure the cloud-sql in the flask api
COPY ./configure-cloudsql-password.sh ../scripts

#Running the Scrip for configuration
# RUN chmod +x ../scripts/configure-cloudsql-password.sh

ENV GOOGLE_CLOUD_PROJECT ${GOOGLE_CLOUD_PROJECT}
ENV GOOGLE_CLOUD_SQL_USERNAME ${GOOGLE_CLOUD_SQL_USERNAME}
ENV GOOGLE_CLOUD_SQL_PASSWORD ${GOOGLE_CLOUD_SQL_PASSWORD}
ENV GOOGLE_CLOUD_SQL_DATABASE ${GOOGLE_CLOUD_SQL_DATABASE}
ENV GOOGLE_CLOUD_SQL_HOST ${GOOGLE_CLOUD_SQL_HOST}
ENV GOOGLE_CLOUD_SQL_PORT ${GOOGLE_CLOUD_SQL_PORT}

# -----------------------------------------------------------------------
#Running the Flask Application for storing the resulted value in the CloudSQL Engine
RUN python3 db.py

EXPOSE 5000

CMD ["python3", "stock_market_prediction.py"]

#Start the application
CMD ["npm", "start"]

