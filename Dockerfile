FROM pandoc/latex:2.17-ubuntu

# for writing in Helvetica font
COPY Helvetica.tgz /tmp/Helvetica.tgz 
RUN tar -xvzf /tmp/Helvetica.tgz && \
    mkdir -p /usr/share/fonts/truetype/Helvetica && \
    mv Helvetica*.ttf /usr/share/fonts/truetype/Helvetica/ && \
    fc-cache -f -v

# additional latex packages
RUN tlmgr install \
    # for entering line numbers
    lineno \
    # for title
    titling titlesec 

# python for pandoc python filter
RUN  apt update && apt install -y python-is-python3 python3-setuptools

# pandoc filter
RUN wget https://github.com/jgm/pandocfilters/archive/refs/tags/1.5.0.tar.gz -O pandocfilter.tar.gz
RUN tar -xvzf pandocfilter.tar.gz
RUN cd pandocfilters-1.5.0 && python setup.py install

# inkscape to convert SVG to other formats
RUN apt update --allow-releaseinfo-change -y && apt install -y inkscape

# copy SVG-to-PDF filter to system PATH 
COPY pandoc-svg.py /usr/local/bin/pandoc-svg.py
RUN chmod -R 755 /usr/local/bin/pandoc-svg.py

ENTRYPOINT ["/bin/bash"]

# for adjusting lists
RUN tlmgr install enumitem

