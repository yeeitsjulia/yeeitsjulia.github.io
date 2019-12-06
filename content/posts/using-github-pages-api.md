---
title: "using github pages api"
date: 2019-12-06T09:30:51-06:00
draft: false
---

### goal

- use Github API to check deployment status of my GH Pages

### resource

- https://developer.github.com/v3/guides/getting-started/

### how to use

- requires authentication to retrieve info about GH Pages site. use Personal Access Token in header of API request:

```
curl -H "Authorization: token $PERSONAL_ACCESS_TOKEN" -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/yeeitsjulia/yeeitsjulia.github.io/pages
```

### slightly irrelevant learnings

- what's the difference between `Deploy keys`, `SSH keys`, `Personal access tokens`?
  - `Deploy keys`: SSH key for a _specific_ repository
  - `SSH keys`: for SSH connections for your whole Github account
  - `Personal access tokens`: used for HTTPS connection and to access Github API. works like OAuth token. control level of access. 

- why is my `README` the published to GH pages instead of `docs/` folder?
  - from [Github Help](https://help.github.com/en/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site): looks like I need to select `/docs` folder as a publishing source in my repo settings. but I don't see that option...
  - from [Github API](https://developer.github.com/v3/repos/pages/#update-information-about-a-pages-site): tried updating source folder using API

```
curl -i -X PUT -H "Authorization: token $PERSONAL_ACCESS_TOKEN" -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/yeeitsjulia/yeeitsjulia.github.io/pages -d '{"source": "master /docs"}'
```
