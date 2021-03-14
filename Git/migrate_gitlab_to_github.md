# Migrate GitLab to GitHub

```
ssh-keygen -t ed25519 -C "dptavernier@gmail.com"
ssh -T git@github.com -i id_ed25519_git
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_git
ssh -T git@github.com

git remote rm origin
git remote add origin git@github.com:tabernarious/nginx-se-challenge.git
git push --mirror origin
```