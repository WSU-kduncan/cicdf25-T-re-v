# Project Description & Diagram
1. Continuous Integration Project Overview
    - What is the goal of this project:
        - The goal of this project is to set up a continuous integration using GitHub Actions to automate the building of a Docker container for a web service and push it to DockerHub whenever a new release is created.
    - What tools are used in this project and what are their roles:
        - Docker: Used to create, deploy, and run applications in containers.
        - DockerHub: A cloud-based registry service for building and shipping Docker images.
        - GitHub Actions: A CI/CD platform that allows automation of software workflows directly in a GitHub repository.
        - GitHub Repository Secrets: Used to securely store sensitive information such as DockerHub credentials for use in GitHub Actions workflows.
    - Diagram of project:
        ![CI Diagram](./Diagram.jpg)

## **.:: Part 1 - Script a Refresh ::.**
### **.: 1. EC2 Instance Details :.**
    A. AMI Information:
        - Name: Project5-CF
        - Public IP: 34.228.106.33
    B. Instance Type:
        - t2.medium
    C. Recommended Volume Size:
        - 30 GB
    D. Security Group Configuration/Justification:
        - Inbound Rules:
            - Type: SSH / Protocol: TCP / Port Range: 22
                - Source 172.59.33.121/32: My Hotspot IP
                - Source 192.168.0.0/23: Within the VPC Range
                - Source 66.213.101.3/32: Troy Public Library IP
                - Source 130.108.0.0/16: Wright State University IP Range
        - Outbound Rules:
            - Type: All traffic / Protocol: All / Port Range: All / 
    
### **.: 2. Docker Setup on OS on the EC2 instance :.**
    A. How to install Docker for OS on the EC2 instance:
        - Docker is installed via the Project5-CF.yml template. It also installs apache2, git, python3, python3-pip, and wamerican.
    B. Additional dependencies based on OS on the EC2 instance:
        - No additional dependencies are required due to the automation presented in the Project5-CF.yml template.
    C. How to confirm Docker is installed and that OS on the EC2 instance can successfully run containers:
        - Simply type "docker --version" in the terminal to confirm Docker is installed.
        - To confirm that the os can run containers, try running "docker run hello-world" which will download and run a test container.

### **.: 3. Testing on EC2 Instance :.**
    A. How to pull container image from DockerHub repository:
        - Pull the image from DockerHub:
            docker pull "dockerhub username"/"repo name":"tag"
    B. How to run container from image (Note the differences between using the `-it` flag and the `-d` flags and which you would recommend once the testing phase is complete):
        - Run the container:
            docker run -d -p "Instance Port":"Local Port" --restart unless-stopped "dockerhub username"/"repo name":"tag"
        - The "-d" (detached mode) is used to run the container in the background. This is best for continuous services. The "-it" (interactive mode) is used for testing and debugging. This way you can work directly inside the container.
    C.  How to verify that the container is successfully serving the web application:
        - Open a web browser and go to http://"EC2 Public IP":"Instance Port"
### **.: 4. Scripting Container Application Refresh :.**