# puppet-ci-playground
Puppet CI/CD with Gitlab and Gitlab CI all running with Docker (demo)

- GitLab
- GitLab CI
- Puppet
- r10k

# How to
`git clone https://github.com/Ananasr/puppet-ci-playground.git`

Go create `code` project in gitlab.
Set `GITLAB_HOST` env var to host container IP address.

1. `docker-compose up -d`
2. `docker build -t test/gitlab-cli -f Dockerfile.gitlab-cli .`
2. `./2createProjectsAndCommitToGitLab.sh`
3. `docker exec -it puppet r10k deploy environment -p` #todo auto
4. `docker exec -it puppet puppet agent --test`
5. `docker exec -it runner gitlab-runner register` #todo auto
6. `docker exec -it runner gitlab-runner run` #todo auto
 
# Todo

- Use Swarm
