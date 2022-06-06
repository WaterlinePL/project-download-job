FROM hyperflowwms/montage2-alpine-node-12:montage5.0-patched

ARG hf_job_executor_version

ENV HYPERFLOW_JOB_EXECUTOR_VERSION=$hf_job_executor_version

RUN npm install -g @hyperflow/job-executor@${HYPERFLOW_JOB_EXECUTOR_VERSION}
RUN apk add --no-cache --upgrade bash unzip

# Install minio client
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc
RUN mv mc /bin/mc

# Assumes folowing laumch: 
# sh download_project.sh <project_name> <model_type:model1> <model_type:model2> <model_type:model3> ...
COPY download_project.sh .
RUN chmod +x download_project.sh