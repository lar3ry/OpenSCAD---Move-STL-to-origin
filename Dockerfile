FROM python:3.6-alpine3.7
WORKDIR /usr/src/app

RUN apk --no-cache add --virtual .builddeps gcc gfortran musl-dev     && pip install numpy==1.14.0     && apk del .builddeps     && rm -rf /root/.cache

# FROM publysher/alpine-numpy

RUN pip install -U MarkupSafe
# RUN wget https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz
# RUN tar -xzf MarkupSafe-2.0.1.tar.gz
# RUN cd MarkupSafe-2.0.1 && python setup.py install
RUN pip3 install --no-cache-dir stl numpy-stl

COPY stldim.py .
COPY .passed_file.stl .

ENTRYPOINT ["python", "./stldim.py" ]
CMD [ ".passed_file.stl" ]