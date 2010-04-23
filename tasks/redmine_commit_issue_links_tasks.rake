desc "Relink commit issue links in the format #1234 for existing commits"
task :redo_commit_issue_links => :environment do
  Changeset.find_in_batches(:batch_size => 40) do |group|
    group.each do |changeset|
      changeset.simple_issue_id_scan
      puts "Scanned changeset ##{changeset.id}, #{changeset.issues.count} issues: #{changeset.issues.map(&:id).join(', ')}"
    end
    sleep 0.2
  end
end
