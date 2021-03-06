FROM iofog/python

RUN pip install jsonpath-rw

COPY index.py /src/
RUN cd /src;

CMD ["python", "/src/index.py", "--log", "DEBUG"]
