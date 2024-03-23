

1. [ * ] docker build . -t devops-project

2. [ ** ] docker run -p 5000:5000 -v $(pwd):/usr/src/app --name devops-project -d devops-project


# Run any Python file in docker as interactive mode (Ensure the container is running before executing any Python file)
1. [ ** ] docker exec -it <CONTAINER_ID> python <FILE_NAME.py>

Happy Coding :)