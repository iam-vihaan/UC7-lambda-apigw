FROM public.ecr.aws/lambda/python:3.11

COPY src/app/requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

COPY src/app/app.py ${LAMBDA_TASK_ROOT}

CMD ["app.lambda_handler"]
