#!/bin/bash
# Convert external GitHub Actions to SHA pins

# Backup
cp -r .github/workflows .github/workflows.backup

# Find external actions (exclude VA org)
grep -rh "uses:" .github/workflows | \
  grep -v "department-of-veterans-affairs" | \
  grep -v "#" | \
  sed 's/.*uses: *//' | \
  grep "@" | \
  sort -u | \
while read action; do
  repo=$(echo $action | cut -d@ -f1)
  tag=$(echo $action | cut -d@ -f2)
  
  # Skip if already SHA
  [[ "$tag" =~ ^[0-9a-f]{40}$ ]] && continue
  
  # Get SHA for tag
  sha=$(git ls-remote https://github.com/$repo.git refs/tags/$tag | awk '{print $1}')
  
  [ -z "$sha" ] && echo "ERROR: $action" && continue
  
  echo "Converting: $action → $sha"
  
  # Replace in all workflows
  find .github/workflows -name "*.yml" | while read file; do
    sed -i "s|uses: $action|uses: $repo@$sha # $tag|g" $file
  done
done

echo "Done! Review with: git diff .github/workflows"