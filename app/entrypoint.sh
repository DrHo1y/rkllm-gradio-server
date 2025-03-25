#!/bin/bash
message_print() {
  echo
  echo "#########################################"
  echo $1
  echo "#########################################"
  echo
}

cd /

message_print "Changing to repository..."
git clone https://github.com/DrHo1y/ezrknn-llm
cd ezrknn-llm/
cp ./rkllm-runtime/runtime/Linux/librkllm_api/aarch64/* /usr/lib
cp ./rkllm-runtime/runtime/Linux/librkllm_api/include/* /usr/local/include

message_print "Compiling LLM runtime for Linux..."
cd ./rkllm-runtime/examples/rkllm_api_demo/
bash build-linux.sh

message_print "Moving rkllm to /usr/bin..."
cp ./build/build_linux_aarch64_Release/llm_demo /usr/bin/rkllm
echo "* soft nofile 16384" >> /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf

message_print "Increasing file limit for all users (needed for LLMs to run)..."
echo "root soft nofile 16384" >> /etc/security/limits.conf
echo "root hard nofile 1048576" >> /etc/security/limits.conf
message_print "Done installing ezrknn-llm!"

message_print "Install python packages"
cd /offline_packages
python -m pip install --no-index --find-links . -r requirements.txt

message_print "Start Gradio server"
cd /app
python rkllm_server_gradio.py