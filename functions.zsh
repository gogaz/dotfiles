# Github only: push all changes to the current branch to a new branch and open the PR in a browser
#   use greset to drop all changes to the current branch
#   change the regex for a different provider
function gitpr() {
  local remote=${1:-origin}
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ $? -ne 0 || -z "$current_branch" ]]; then
    echo "Not in a git repository"
    return 1
  fi

  local commit_message=$(git log -1 --pretty=%B)
  if [[ -z "$commit_message" ]]; then
    echo "Make a commit first"
    return 1
  fi

  local branch_name=$(echo "$commit_message" | ruby -e '
    msg = STDIN.read
    parts = msg.scan(/\[([^\]]+)\]/).flatten.map(&:downcase)
    rest = msg.split("]").last.to_s.scan(/\w+/).select { |w| w.length >= 3 }.map(&:downcase).join("-")
    puts parts.empty? ? rest : "#{parts.join("/")}/#{rest}"
  ')

  echo "🚀 Pushing $current_branch to $remote as $branch_name..."

  git push $remote "$current_branch:$branch_name" 2>&1 | tee /dev/tty | {
    while IFS= read -r line; do
      if [[ "$line" =~ remote:.*\/pull\/new ]]; then
        pr_url=$(echo "$line" | awk '{ print $2 }')
        echo "DEBUG: $line"
        
        if [[ -n "$pr_url" ]]; then
          echo "🔗 PR link detected: $pr_url"

          if command -v open >/dev/null; then
            open "$pr_url"        # macOS
          elif command -v xdg-open >/dev/null; then
            xdg-open "$pr_url"    # Linux
          fi
        fi
      fi
    done
  }
}

function greset() {
  local remote=${1:-origin}
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ $? -ne 0 || -z "$current_branch" ]]; then
    echo "Not in a git repository"
    return 1
  fi

  git reset --hard "$remote/$current_branch"
}
