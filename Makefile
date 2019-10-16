JENKINS_BACKUP_COMMIT_MESSAGE ?= Upgrade and backup of Jenkins ❤️ 
JENKINS_BACKUP_BRANCH ?= jenkins-backup


release-create:
	git checkout master && \
	git fetch origin && \
	git branch -D $(JENKINS_BACKUP_BRANCH) && \
	git checkout -b $(JENKINS_BACKUP_BRANCH) origin/master && \
	git add . && git commit -m "$(JENKINS_BACKUP_COMMIT_MESSAGE)" && \
	git push origin $(JENKINS_BACKUP_BRANCH)