require 'changeset'

module RedmineCommitIssueLinks

  def self.included(base)
    base.after_create :simple_issue_id_scan
  end
  
  # Ensure basic refs like #123 are linked up too
  def simple_issue_id_scan
    return if comments.blank? or @performed_scan
    @performed_scan = true
    referenced_issues = []
    comments.scan(/#(\d+)/).uniq.each do |issue_id|
      if issue = repository.project.issues.find_by_id(issue_id)
        referenced_issues += [issue]
      end
    end
    
    self.issues += referenced_issues
    self.issues.uniq
    save
  end
  
end
