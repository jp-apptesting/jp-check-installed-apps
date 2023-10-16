#/bin/ksh
# Open the file in read mode.
file=teams-users.csv
while read line; do
  # Print the current line to the console.
  team="$(echo "$line" | cut -d '|' -f 1)"
  user="$(echo "$line" | cut -d '|' -f 2)"
  echo "team is $team"
  echo "user is $user"
  gh api   --method POST   -H "Accept: application/vnd.github+json"   -H "X-GitHub-Api-Version: 2022-11-28"   /orgs/jp-apptesting/teams   -f name=$team  -f description="A great $team team"  -f permission='push'  -f notification_setting='notifications_enabled'  -f privacy='closed'
  gh api --method PUT -H "Accept: application/vnd.github+json"   -H "X-GitHub-Api-Version: 2022-11-28" /orgs/jp-apptesting/teams/$team/memberships/$user
done < $file
