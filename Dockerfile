FROM python:3.6-alpine3.7
WORKDIR /usr/src/app

RUN apk --no-cache add --virtual .builddeps gcc gfortran musl-dev     && pip install numpy==1.14.0     && apk del .builddeps     && rm -rf /root/.cache
RUN pip install -U MarkupSafe
RUN pip3 install --no-cache-dir stl numpy-stl

COPY stldim.py .
COPY .passed_file.stl .

ENTRYPOINT ["python", "./stldim.py" ]
CMD [ ".passed_file.stl" ]