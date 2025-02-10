FROM registry.cn-hangzhou.aliyuncs.com/funasr_repo/funasr:funasr-runtime-sdk-online-cpu-0.1.12

WORKDIR /workspace/FunASR/runtime

RUN chmod +x run_server_2pass.sh
COPY ./entrypoint.sh /workspace/FunASR/runtime/entrypoint.sh
COPY ./funasr-runtime-resources/models /workspace/models
RUN chmod +x entrypoint.sh
CMD ./entrypoint.sh
