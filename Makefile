JENKINS_BACKUP_COMMIT_MESSAGE ?= Upgrade and backup of Jenkins ❤️ 
JENKINS_BACKUP_BRANCH ?= jenkins-backup
REPO_NAME ?= test-repo
ORG_NAME ?= parithibang
GITHUB_TOKEN ?= ${GITHUB_TOKEN}



release-create:
	git checkout master && \
	git fetch origin && \
	git branch -D $(JENKINS_BACKUP_BRANCH) && \
	git checkout -b $(JENKINS_BACKUP_BRANCH) origin/master && \
	git add . && git commit -m "$(JENKINS_BACKUP_COMMIT_MESSAGE)" && \
	git push origin -f $(JENKINS_BACKUP_BRANCH)
	make create-pull-request

create-pull-request:
	$(eval API_STATUS := $(shell curl  -o -L -s -w "%{http_code}" -X POST \
  https://api.github.com/repos/$(ORG_NAME)/$(REPO_NAME)/pulls \
  -H 'Accept: application/vnd.github.mercy-preview+json' \
  -H 'Authorization: token $(GITHUB_TOKEN)' \
  -H 'Host: api.github.com' \
  -H 'Content-Type: application/json' \
  -d '{ \
"title": "$(JENKINS_BACKUP_COMMIT_MESSAGE)", \
"head":"$(JENKINS_BACKUP_BRANCH)", \
"base":"master" \
}'))

ifeq ($(API_OUTPUT),201)
	@echo "Pull request created successfully"
else
	@echo "There is a problem in creating pull request"
endif
