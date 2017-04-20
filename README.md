# CI/CD Playground for Puppet infrastructure using Docker (demo)

- GitLab
- GitLab CI
- Puppet
- r10k

# How to
Go create `code` project in gitlab

1. `docker-compose up -d`
2. `./2createProjectsAndCommitToGitLab.sh`
3. `docker exec -it puppet r10k deploy environment -p`
4. `docker exec -it puppet puppet agent --test`
5. `docker exec -it runner gitlab-runner register`
6. `docker exec -it runner gitlab-runner run`
 
# Todo

Use Swarm
