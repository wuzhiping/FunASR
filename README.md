# FunASR
https://github.com/modelscope/FunASR/blob/main/runtime/docs/SDK_advanced_guide_online_zh.md

```code
docker run --rm -it -p 10096:10095 --privileged=true \
  -v $PWD/funasr-runtime-resources/models:/workspace/models \
  registry.cn-hangzhou.aliyuncs.com/funasr_repo/funasr:funasr-runtime-sdk-online-cpu-0.1.12

cd FunASR/runtime
nohup bash run_server_2pass.sh \
  --download-model-dir /workspace/models \
  --vad-dir damo/speech_fsmn_vad_zh-cn-16k-common-onnx \
  --model-dir damo/speech_paraformer-large-vad-punc_asr_nat-zh-cn-16k-common-vocab8404-onnx  \
  --online-model-dir damo/speech_paraformer-large_asr_nat-zh-cn-16k-common-vocab8404-online-onnx  \
  --punc-dir damo/punc_ct-transformer_zh-cn-common-vad_realtime-vocab272727-onnx \
  --lm-dir damo/speech_ngram_lm_zh-cn-ai-wesp-fst \
  --itn-dir thuduj12/fst_itn_zh \
  --certfile 0 \
  --hotword /workspace/models/hotwords.txt > log.txt 2>&1 &

docker build -t shawoo/funasr:funasr-runtime-sdk-online-cpu-0.1.12 .

docker run --rm -it -p 10096:10095 --privileged=true shawoo/funasr:funasr-runtime-sdk-online-cpu-0.1.12
```

https://github.com/modelscope/FunASR/tree/main/runtime/html5

# nginx
```code
  location /ASR/ {

     rewrite ^/ASR/(.*) /$1 break;
     proxy_pass http://asr-server:10095;

     #proxy_set_header X-Real-IP $remote_addr;
     #proxy_set_header Host $host;
     #proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_http_version 1.1;
     proxy_set_header Upgrade $http_upgrade;
     proxy_set_header Connection "upgrade";
     proxy_set_header Host $host;
  }

```
