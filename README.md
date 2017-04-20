# CI/CD Playground for Puppet infrastructure using Docker (demo)

- GitLab
- GitLab CI
- Puppet
- r10k

# How to
1. `docker-compose up -d`
2. `./2createProjectsAndCommitToGitLab.sh`
3. `docker exec -it puppet r10k deploy environment -p`
4. `docker exec -it puppet puppet agent --test`
 
# Todo

Use Swarm
