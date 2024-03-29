# cgit

[cgit](https://git.zx2c4.com/cgit/about/) is a self hosted web fontend for [git](https://git-scm.com/).

## Configuration

To persist repositories and cache between containers you can mount two volumes.

```yaml
version: '3'
services:
  cgit:
    container_name: cgit
    image: ghcr.io/aaqaishtyaq/cgit:latest
    ports:
      - 8010:80
    volumes:
      - /mnt/cgit/assets/:/usr/share/webapps/cgit/static/
      - /mnt/repositories/:/repositories/
      - /mnt/cgit/cache/:/var/cache/cgit
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
