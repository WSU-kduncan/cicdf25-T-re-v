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
    A. The bash script will stop and remove the current running container. Then Pull the latest tagged image from DockerHub and run a new container process with the pulled image.
    B. To test the script, open a terminal and navigate to the directory with the script. Then run this command in the terminal:
        bash "script_name".sh
### C. [Script](./refresh.sh)

## **.:: Part 2 - Listen ::.**
### **.: 1. Configuring a webhook Listener on EC2 Instance :.**
    A. Use this code to install the adnanh webook:
        - sudo apt install webhook
    B. To verify the installation, run this command:
        - webhook -version
    C. The definition file for the webhook will trigger the bash script to refresh the container application when a webhook event is received from GitHub Actions.
    D. To verify the definition file was loaded, run the command:
        - curl -X POST http://localhost:"port"/hooks/"hook_name"
        - journalctl -u webhook -f
        - This will show the logs for the webhook service and confirm that the hook was received and processed.
        - In the Docker process views, you'll see the old container stop and a new container start up.
### E. [Webhook Definition](./webhook.yml)

### **.: 2. Configure a webhook Service on EC2 Instance :.**
    A. The webhook service file stops and removes the old container, pulls the latest tagged image from DockerHub, and runs a new container from the pulled image.
    B. To start and enable the webhook service, run these commands:
        - sudo systemctl start webhook
        - sudo systemctl enable webhook
    C. To verify the webhook service is capturing payloads and triggering script, use this command:
        - journalctl -u webhook -f
### D. [Webhook Service](./refresh.sh)

## **.:: Part 3 - Send A Payload ::.**
### **.: 1. Configuring A Payload Sender :.**
    A. I chose GitHub because a SECRET token could be applied to the webhook for an extra layer of payload security.
    B. In GitHub, go to the repository settings, then go to "Webhooks" and click "Add webhook". There you can enter the payload URL, content type, and secret token.
    C. For simplicity, I chose to send the payload on every push to the main branch.
    D. To test the payload sender, make a push to the main branch. Then, on GitHub,check the webhook logs for the webhook event.
    E. For GitHub simply create a new branch and push to it. Then check the webhook logs on GitHub to confirm no payloads were sent or received.

## **.:: References ::.**
1. [Webhook As A Listening Service](https://github.com/pattonsgirl/CEG3120/blob/main/CourseNotes/webhook.md)
2. [DockerDocs - Webhooks](https://docs.docker.com/docker-hub/repos/manage/webhooks/)
3. [GitHubDocs - Webhook Events and Payloads](https://docs.github.com/en/webhooks/webhook-events-and-payloads)
4. [DeepWiki - adnanh/webhook](https://deepwiki.com/adnanh/webhook/3-hook-configuration)
5. [Copilot - With Absolute Shame](https://copilot.microsoft.com/) 
    - Copilot was used to help generate the webhook.yml file. 
    - It was the main source for troubleshooting everything relating to getting webhooks working.

## **.:: Post Presentation Fixes ::.**
1. Fixed the security groups to include Wright State University IP range: 130.108.0.0/16
2. Added a trigger to the webhook.