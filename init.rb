require 'changeset'
require File.join(File.dirname(__FILE__), 'lib', 'redmine_commit_issue_links')

Changeset.send :include, RedmineCommitIssueLinks
