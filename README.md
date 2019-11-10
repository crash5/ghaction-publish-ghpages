# Publish to GitHub Pages Action


## Usage

Need a Personal Access Token secret in the repository. (`secrets.GH_TOKEN` in the examples)
  1. [Generate token](https://github.com/settings/tokens)
  2. Add into the repository: Repository Settings > Secrets: Add new secret

Change **v1** to the desired version in the examples.


### As action step

```yaml
- name: Deploy
  uses: crash5/ghaction-publish-ghpages@v1
  with:
    token: ${{ secrets.GH_TOKEN }}
    sourceDirectory: output
```


### As a script step

```yaml
- name: Deploy
  env:
    INPUT_TOKEN: ${{ secrets.GH_TOKEN }}
    INPUT_SOURCEDIRECTORY: output
  run: |
    wget https://raw.githubusercontent.com/crash5/ghaction-publish-ghpages/v1/entrypoint.sh
    bash ./entrypoint.sh
```
