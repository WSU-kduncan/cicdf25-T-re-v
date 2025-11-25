## Part 4 - Project Description & Diagram
### Building a Web Service Container
- **Create a Dockerfile using a plain text document and save it.** (The name must be all lowercase)
    - First Line: FROM
        - Used for setting the base image of the container. Below is an example for creating an Apache image with the latest version.
        - Example: FROM httpd:latest
    - Second Line: COPY
        - Used for copying files from the host to the container. In this case we're copying the web content files to Apache's httpd directory.
        - Example: COPY /web-content/ /usr/local/apache2/htdocs/
            - [Docker Site](web-content/docker.html) - Site with common Dockerfile commands.
            - [Linux Commands](web-content/index.html) - Site with common Linux commands.
            - [CSS File](web-content/style.css) - CSS file for both HTML files.
    
    - Dockerfile: [Dockerfile](dockerfile)
- **The command to create the container from this image**
    - docker build -t dockerfile:project3 .
        - "-t" creates the terminal interface for the container
        - "dockerfile" is the name of the file to copied.
        - "project3" is the name tag for the container.
- **Pushing the Container to DockerHub**
    - In a terminal, use "docker login" to log 
    - Tag the image with your Dockerhub username and the repository name.
        - docker tag "image name" "dockerhub username"/"repo name":"tag"
        - docker tag my_image user/repo_name:first_tag
    - Push the image to DockerHub
        - docker push "dockerhub username"/"repo name":"tag"
        - docker push user/repo_name:first_push
- **Create a Container from DockerHub**
    - Pull the image from DockerHub:
        - docker pull "dockerhub username"/"repo name":"tag"
    - Run the container:
        - docker run -d -p 8000:80 --restart unless-stopped "dockerhub username"/"repo name":"tag"
        
- **Creating a Personal Access Token (PAT)**
    - When logging in to DockerHub, use your PAT in place of your password.
    
### Instructions
1. Select your avatar in the top-right corner and from the drop-down menu select Account settings.
2. Select Personal access tokens.
3. Select Generate new token.
4. Configure your token:

    - Description: Use a descriptive name that indicates the token's purpose
    - Expiration date: Set an expiration date based on your security policies
    - Access permissions: Read, Write, or Delete. (Set to read & write to be able to push)
5. Select Generate. Copy the token that appears on the screen and save it. You won't be able to retrieve the token once you exit the screen.

### Web Content
- The 