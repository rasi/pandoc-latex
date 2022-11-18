# Docker build for Pandoc+LaTeX

This build is used for writing manuscripts in Markdown and converting them to PDF through Pandoc and (Xe)LaTeX

To compile files using this image:

1. Pull this image to your computer (change TAG below):

```bash
docker pull ghcr.io/rasilab/pandoc-latex:TAG
```

2. Start a container `pandoc-latex` from this image (change TAG below):

```bash
docker run -i -d --name pandoc-latex -v $HOME:$HOME ghcr.io/rasilab/pandoc-latex:TAG
```

3. Run `pandoc` using the above running container:

```bash
docker exec -w $(pwd) pandoc-latex pandoc <manuscript>.md --citeproc --template=latex_templates/manuscript.tex --metadata-file=pandoc-options.yaml --pdf-engine=xelatex -o <manuscript>.pdf --filter=pandoc-svg.py
```

See [Dockerfile](./Dockerfile) for the build details.

The commit tag and the package tag are set to be the same as the software version.
