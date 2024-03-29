prefix := "/"

serve:
    #!/usr/bin/env bash
    poetry run mkdocs serve

all:
    #!/usr/bin/env bash
    set -euxo pipefail
    CALENDAR_TODAY="today in 10 years" poetry run mkdocs serve

archive:
    #!/usr/bin/env bash
    set -euxo pipefail
    target="devops-website-2022-2023.wzip"
    rm -Rf public
    rm $target || true
    poetry run mkdocs build -d public -f mkdocs.yml
    echo {{ prefix }} >public/.prefix
    cd public && zip -FS -r ../$target . && cd ..
