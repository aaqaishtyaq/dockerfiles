# cgit

[cgit](https://git.zx2c4.com/cgit/about/) is a self hosted web fontend for [git](https://git-scm.com/).

## Configuration

To persist repositories and cache between containers you can mount two volumes.

```yaml
cgit:
  container_name: cgit
  image: ghcr.io/aaqaishtyaq/cgit
  ports:
    - 8181:80
  volumes:
    # Add static assets for custom logo, favicon and css
    # - logo.png
    # - favicon.png
    # - cgit.css
    - /tmp/git/as:/usr/share/webapps/cgit/static/
    # Persist git repositories cache
    - /tmp/git/source/:/repositories/
    - /tmp/git/cache/:/var/cache/cgit
  environment:
    CGIT_TITLE: 'git.aaqa.dev'
    CGIT_DESC: "Aaqa Ishtyaq's git forge"
    # check section-from-path in cgit docs
    CGIT_VROOT: '/'
    CGIT_SECTION_FROM_STARTPATH: 1
    CGIT_MAX_REPO_COUNT: 50
```

```console
% docker-compose up
```

You can also checkout the sample `docker-compose` file for more config options.
