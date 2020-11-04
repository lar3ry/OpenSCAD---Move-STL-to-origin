FROM publysher/alpine-numpy
WORKDIR /usr/src/app

RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir markupsafe
RUN pip3 install --no-cache-dir stl numpy-stl

COPY stldim.py .
COPY .passed_file.stl .

ENTRYPOINT ["python", "./stldim.py" ]
CMD [ ".passed_file.stl" ]
